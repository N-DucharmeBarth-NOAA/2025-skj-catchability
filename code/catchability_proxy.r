

# Nicholas Ducharme-Barth
# 2025/04/11
# Calculate free-school catchability proxy using the same methodology described in:
# Hamer et al., 2024. WCPFC-SC20-2024/SA-IP-16 <https://meetings.wcpfc.int/node/22984>

# Copyright (c) 2025 Nicholas Ducharme-Barth
# You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.

#_____________________________________________________________________________________________________________________________
# load packages
	library(data.table)
    library(magrittr)
    library(FLR4MFCL)
    library(ggplot2)

#_____________________________________________________________________________________________________________________________
# define paths
	proj_dir = this.path::this.proj()

#_____________________________________________________________________________________________________________________________
# Extract public purse seine catch data and restrict to assessment regions 6-8
# Catch data is sourced from WCPFC public data repository <https://www.wcpfc.int/node/4648>
# Aggregated data, grouped by 5°x5° latitude/longitude grids, YEAR and MONTH.
# PURSE SEINE fishery. Data cover 1950 to 2023 for the WCPFC Convention Area.
    catch_una_dt = fread(file.path(proj_dir,"data","WCPFC_S_PUBLIC_BY_YR_MON.CSV")) %>%
      .[,.(days=sum(days),skj=sum(skj_c_una),total=sum(skj_c_una+yft_c_una+bet_c_una+oth_c_una)),by=.(yy,lat5,lon5)] %>%
      .[,lat_num := as.numeric(gsub("N","",gsub("S","",lat5)))] %>%
      .[,lat_char := substr(lat5,3,3)] %>%
      .[,lat := ifelse(lat_char=="N",lat_num,-lat_num)+2.5] %>%
      .[,lon_num := as.numeric(gsub("E","",gsub("W","",lon5)))] %>%
      .[,lon_char := substr(lon5,4,4)] %>%
      .[,lon := ifelse(lon_char=="E",lon_num,(180-lon_num)+180)+2.5] %>%
      .[lon>=140 & lon<=210 & lat>= -10 & lat <= 10] %>%
      .[,.(days=sum(days),skj=sum(skj),total=sum(total)),by=.(yy)] %>%
      melt(.,id.vars=c("yy","days")) %>%
      .[,set_type:="Un-Associated"] %>%
      .[,.(set_type,yy,days,variable,value)]
    
    catch_dfad_dt = fread(file.path(proj_dir,"data","WCPFC_S_PUBLIC_BY_YR_MON.CSV")) %>%
      .[,.(days=sum(days),skj=sum(skj_c_dfad),total=sum(skj_c_dfad+yft_c_dfad+bet_c_dfad+oth_c_dfad)),by=.(yy,lat5,lon5)] %>%
      .[,lat_num := as.numeric(gsub("N","",gsub("S","",lat5)))] %>%
      .[,lat_char := substr(lat5,3,3)] %>%
      .[,lat := ifelse(lat_char=="N",lat_num,-lat_num)+2.5] %>%
      .[,lon_num := as.numeric(gsub("E","",gsub("W","",lon5)))] %>%
      .[,lon_char := substr(lon5,4,4)] %>%
      .[,lon := ifelse(lon_char=="E",lon_num,(180-lon_num)+180)+2.5] %>%
      .[lon>=140 & lon<=210 & lat>= -10 & lat <= 10] %>%
      .[,.(days=sum(days),skj=sum(skj),total=sum(total)),by=.(yy)] %>%
      melt(.,id.vars=c("yy","days")) %>%
      .[,set_type:="Drifting FAD"] %>%
      .[,.(set_type,yy,days,variable,value)]
    
    catch_dt = rbind(catch_una_dt,catch_dfad_dt)

#_____________________________________________________________________________________________________________________________
# extract model estimates from the 2022 diagnostic case (T2G10.8)
# model files were available from <https://oceanfish.spc.int/en/ofpsection/sam/sam/213-skipjack-assessment-results#2022>
    rep = read.MFCLRep(file.path("data","T2G10.8","plot-09.par.rep"))
    # limit to regions 6-8
    bio_dt = as.data.table(totalBiomass(rep)) %>%
            .[area %in% c(6,7,8)] %>%
            .[,.(bio=sum(value)),by=year] %>%
            .[,yy:=as.numeric(year)] %>%
            .[,.(yy,bio)]

    # merge data
    q_dt = merge(catch_dt,bio_dt,by="yy") %>%
        .[,q_proxy:=value/days/bio] %>%
        .[yy>=2008] %>%
        .[,q_proxy:=q_proxy/mean(q_proxy),by=variable] %>%
        .[,variable:=factor(variable,levels=c("skj","total"),labels=c("Skipjack catch","Total catch"))] %>%
        setnames(.,"variable","catch_type")
    
    fwrite(q_dt,file=file.path("output","q_dt.csv"))

#_____________________________________________________________________________________________________________________________
# make figures
    p = ggplot(q_dt,aes(x=yy,y=q_proxy)) +
        facet_grid(set_type~catch_type) +
        geom_point() +
        geom_smooth(method = "lm") +
        ylab("Catchability proxy (mean-centered)") +
        xlab("Year") +
        theme(panel.background = element_rect(fill = "white", color = "black", linetype = "solid"),
                    panel.grid.major = element_line(color = 'gray70', linetype = "dotted"),
                    panel.grid.minor = element_line(color = 'gray70', linetype = "dotted"),
                    strip.background = element_rect(fill = "white"),
                    legend.key = element_rect(fill = "white"))

