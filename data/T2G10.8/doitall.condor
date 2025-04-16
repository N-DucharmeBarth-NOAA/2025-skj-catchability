#!/bin/sh
cd $_CONDOR_SCRATCH_DIR
export PATH=.:$PATH
export ADTMP1=.
#$MFCL
# PHASE 0  - create the initial par file 
# ---------
if [ ! -f 00.par ]; then
    ./mfclo64 skj.frq skj.ini 00.par -makepar
fi
# ---------
#  PHASE 1 
# ---------
if [ ! -f 01.par ]; then
     ./mfclo64 skj.frq 00.par 01.par -file - <<PHASE1
#-------------------------------------------------------------------------------  
#  Initial Phase Control option  
  1 32 7         # control phase - keep growth parameters fixed
  1 387 1        # DOn't know what this does !!!!!
#-------------------------------------------------------------------------------
# Catch conditioned flags
#  general activation
  1 373 1         # activated CC with Baranov equation
  1 393 1         # activate estimation of: kludged_equilib_coffs, and implicit_fm_level_regression_pars
  2 92 2          # specifies the catch-conditioned option with Baranov equation
# - catch equation bounds
  2 116 80        # value for Zmax_fish in the catch equations
  2 189 80        # the fraction of Zmax_fish above which the penalty is calculated
  1 382 300       # weight for Zmax_fish penalty - set to 300 to avoid triggering Zmax_flag=1. Found by T&E.
# De-activate any catch errors flags
  -999 1 0
  -999 4 0
  -999 10 0
  -999 15 0
  -999 13 0
# -- survey fisheries defined
#  Index wt   Time varying CV
  -32 92 52    -32 66 0      # PL JP 1
  -33 92 52    -33 66 0      # PL JP 2
  -34 92 52    -34 66 0      # PL JP 3
  -35 92 52    -35 66 0      # PL JP 4
  -36 92 286   -36 66 0      # PS PH 5 (based on fishery 12)
  -37 92 52    -37 66 0      # PL JP 7 
  -38 92 52    -38 66 0      # PL JP 8
  -39 92 83    -39 66 0      # PS UNA 6
  -40 92 83    -40 66 0      # PS UNA 7
  -41 92 83    -41 66 0      # PS UNA 8
# -- Grouping flags for survey CPUE
    -1 99 1
    -2 99 2
    -3 99 3
    -4 99 4
    -5 99 5
    -6 99 6
    -7 99 7
    -8 99 8
    -9 99 9
   -10 99 10
   -11 99 11
   -12 99 12
   -13 99 13
   -14 99 14
   -15 99 15
   -16 99 16
   -17 99 17
   -18 99 18
   -19 99 19
   -20 99 20
   -21 99 21
   -22 99 22
   -23 99 23
   -24 99 24
   -25 99 25
   -26 99 26
   -27 99 27
   -28 99 28
   -29 99 29
   -30 99 30
   -31 99 31
   -32 99 32
   -33 99 32
   -34 99 32
   -35 99 32
   -36 99 33
   -37 99 32
   -38 99 32
   -39 99 34
   -40 99 34
   -41 99 34
# Recruitment and Initial Population Settings 
   1 149 100      # penalty on recruitment devs n/10 so for 100 = 1/sqrt(2*100/10) - CV ~ 0.22    
   1 400 2        # set the last 2 recruitment deviates to 0
   1 398 0        # Sets terminal recruitments at geometric mean 
   2 113 0        # estimate initpop/totpop scaling parameter
   2 177 1        # use old totpop scaling method
   2 32 1         # totpop estimated from this phase   
   2 57 4         # 4 recruitments per year
   2 93 4         # 4 recruitments per year
   2 94 2         # Use equilibium initial population
   2 95 20        # Use average Z for first 20 periods for equil. init. pop.
#  -- kludged initial survival relationship
   1 374 4        # Spline degree for initial survival
   1 375 1000     # penalty weight on initial survival
   1 379 100      # penalty wt on high (>4) spline degrees for kludged_equilib_coeffs
 
#-------------------------------------------------------------------------------
# Likelihood Component
   1 141 3        # Robust normal likelihood function for LF data
   1 111 4        # Negative binomial likelihood function for tags
   -999 49 100     # Divisor for LF sample sizes effective sample size 

#-------------------------------------------------------------------------------
# Tagging Related Flags
#
  -9999 1 1       # Tag returns for first period after release disregarded
  -9999 2 0       # Zero means applying the tag_rep_rate in the tag catch calculation; 1 means we are excluding it
  1 33 90         # Maximum tag reporting rate for all fisheries is 0.9
  2 198 1         # Turn on release group reporting rates which are specified in the .ini
  1 305 1 	  # Estimate the variance parameter of the negative binomial 
  -999 43 1       # Var parameter estimated for all fisheries 
  -999 44 1       # All fisheries grouped for estimating tag neg bin var parameter
  2 96 12         # Tags are pooled across release groups after 12 periods   CHECK THIS - LOWER AND WOULD SPEED UP
# Variable mixing periods by tag release groups
 -10000	1	0		-10049	1	1		-10098	1	1		-10147	1	1		-10196	1	0		-10245	1	2		-10294	1	4
 -10001	1	4		-10050	1	1		-10099	1	1		-10148	1	1		-10197	1	0		-10246	1	0		-10295	1	1
 -10002	1	0		-10051	1	1		-10100	1	1		-10149	1	1		-10198	1	0		-10247	1	0		-10296	1	1
 -10003	1	0		-10052	1	4		-10101	1	1		-10150	1	1		-10199	1	0		-10248	1	0		-10297	1	1
 -10004	1	1		-10053	1	0		-10102	1	1		-10151	1	1		-10200	1	0		-10249	1	0		-10298	1	1
 -10005	1	1		-10054	1	0		-10103	1	1		-10152	1	1		-10201	1	0		-10250	1	0		-10299	1	1
 -10006	1	1		-10055	1	0		-10104	1	1		-10153	1	1		-10202	1	0		-10251	1	4		-10300	1	1
 -10007	1	1		-10056	1	0		-10105	1	1		-10154	1	1		-10203	1	0		-10252	1	4		-10301	1	1
 -10008	1	1		-10057	1	4		-10106	1	1		-10155	1	1		-10204	1	2		-10253	1	4		-10302	1	1
 -10009	1	1		-10058	1	4		-10107	1	1		-10156	1	1		-10205	1	0		-10254	1	4		-10303	1	1
 -10010	1	1		-10059	1	2		-10108	1	1		-10157	1	1		-10206	1	0		-10255	1	4		-10304	1	1
 -10011	1	1		-10060	1	0		-10109	1	0		-10158	1	1		-10207	1	0		-10256	1	4		-10305	1	1
 -10012	1	1		-10061	1	1		-10110	1	0		-10159	1	1		-10208	1	1		-10257	1	4		-10306	1	1
 -10013	1	1		-10062	1	1		-10111	1	1		-10160	1	1		-10209	1	0		-10258	1	4		-10307	1	1
 -10014	1	1		-10063	1	1		-10112	1	1		-10161	1	1		-10210	1	0		-10259	1	4		-10308	1	1
 -10015	1	1		-10064	1	2		-10113	1	1		-10162	1	1		-10211	1	0		-10260	1	4		-10309	1	1
 -10016	1	1		-10065	1	2		-10114	1	1		-10163	1	1		-10212	1	1		-10261	1	4		-10310	1	1
 -10017	1	1		-10066	1	1		-10115	1	0		-10164	1	1		-10213	1	0		-10262	1	4		-10311	1	1
 -10018	1	1		-10067	1	1		-10116	1	0		-10165	1	1		-10214	1	0		-10263	1	4		-10312	1	0
 -10019	1	1		-10068	1	2		-10117	1	1		-10166	1	1		-10215	1	0		-10264	1	4		-10313	1	1
 -10020	1	1		-10069	1	1		-10118	1	1		-10167	1	1		-10216	1	0		-10265	1	4		-10314	1	1
 -10021	1	1		-10070	1	1		-10119	1	1		-10168	1	0		-10217	1	0		-10266	1	4		-10315	1	0
 -10022	1	1		-10071	1	4		-10120	1	1		-10169	1	1		-10218	1	0		-10267	1	4		-10316	1	1
 -10023	1	0		-10072	1	1		-10121	1	1		-10170	1	1		-10219	1	0		-10268	1	4		-10317	1	1
 -10024	1	0		-10073	1	4		-10122	1	0		-10171	1	1		-10220	1	1		-10269	1	1		-10318	1	1
 -10025	1	0		-10074	1	1		-10123	1	1		-10172	1	1		-10221	1	0		-10270	1	1		-10319	1	1
 -10026	1	0		-10075	1	1		-10124	1	0		-10173	1	1		-10222	1	1		-10271	1	1		-10320	1	1
 -10027	1	0		-10076	1	1		-10125	1	1		-10174	1	1		-10223	1	1		-10272	1	0		-10321	1	1
 -10028	1	0		-10077	1	2		-10126	1	1		-10175	1	2		-10224	1	2		-10273	1	0		-10322	1	1
 -10029	1	1		-10078	1	3		-10127	1	1		-10176	1	2		-10225	1	2		-10274	1	0		-10323	1	1
 -10030	1	1		-10079	1	2		-10128	1	1		-10177	1	1		-10226	1	1		-10275	1	4		-10324	1	1
 -10031	1	1		-10080	1	0		-10129	1	1		-10178	1	2		-10227	1	2		-10276	1	4		-10325	1	1
 -10032	1	1		-10081	1	2		-10130	1	1		-10179	1	2		-10228	1	0		-10277	1	2		-10326	1	1
 -10033	1	1		-10082	1	0		-10131	1	1		-10180	1	1		-10229	1	2		-10278	1	0		-10327	1	1
 -10034	1	1		-10083	1	0		-10132	1	1		-10181	1	1		-10230	1	1		-10279	1	0				
 -10035	1	1		-10084	1	2		-10133	1	1		-10182	1	1		-10231	1	0		-10280	1	4				
 -10036	1	1		-10085	1	1		-10134	1	1		-10183	1	0		-10232	1	0		-10281	1	4				
 -10037	1	1		-10086	1	3		-10135	1	1		-10184	1	0		-10233	1	1		-10282	1	4				
 -10038	1	1		-10087	1	2		-10136	1	1		-10185	1	0		-10234	1	0		-10283	1	4				
 -10039	1	1		-10088	1	0		-10137	1	1		-10186	1	0		-10235	1	0		-10284	1	4				
 -10040	1	1		-10089	1	1		-10138	1	1		-10187	1	0		-10236	1	1		-10285	1	4				
 -10041	1	1		-10090	1	1		-10139	1	1		-10188	1	0		-10237	1	0		-10286	1	4				
 -10042	1	1		-10091	1	1		-10140	1	1		-10189	1	0		-10238	1	0		-10287	1	4				
 -10043	1	1		-10092	1	1		-10141	1	1		-10190	1	0		-10239	1	1		-10288	1	4				
 -10044	1	1		-10093	1	1		-10142	1	1		-10191	1	0		-10240	1	0		-10289	1	4				
 -10045	1	1		-10094	1	1		-10143	1	1		-10192	1	0		-10241	1	0		-10290	1	3				
 -10046	1	1		-10095	1	1		-10144	1	1		-10193	1	0		-10242	1	0		-10291	1	4				
 -10047	1	1		-10096	1	1		-10145	1	1		-10194	1	0		-10243	1	2		-10292	1	0				
 -10048	1	1		-10097	1	1		-10146	1	1		-10195	1	0		-10244	1	2		-10293	1	0				
# ------------------------------------------------------------------------------
# Selectivity grouping  and form     1=logistic  2=doublenormal 3=cubic spine or length specific
# -N 24 X is the selectivity grouping
# -N 57 3 is cubic spline selectivity
# -N 61 X establishes that there are X nodes in the spline
  -1 24  1    -1 57 3     -1 61 4           
  -2 24  2    -2 57 3     -2 61 4
  -3 24  3    -3 57 3     -3 61 3     -3 16 1
  -4 24  1    -4 57 3     -4 61 4
  -5 24  2    -5 57 3     -5 61 4
  -6 24  3    -6 57 3     -6 61 3     -6 16 1
  -7 24  1    -7 57 3     -7 61 4
  -8 24  2    -8 57 3     -8 61 4
  -9 24  3    -9 57 3     -9 61 3     -9 16 1
 -10 24  4   -10 57 3    -10 61 6
 -11 24  5   -11 57 3    -11 61 5
 -12 24  6   -12 57 3    -12 61 5
 -13 24  7   -13 57 3    -13 61 6
 -14 24  8   -14 57 3    -14 61 4
 -15 24  9   -15 57 3    -15 61 4
 -16 24 10   -16 57 3    -16 61 5
 -17 24 11   -17 57 3    -17 61 3     -17 16 1
 -18 24 12   -18 57 3    -18 61 4
 -19 24  8   -19 57 3    -19 61 4
 -20 24  9   -20 57 3    -20 61 4
 -21 24 11   -21 57 3    -21 61 3     -21 16 1
 -22 24  1   -22 57 3    -22 61 4
 -23 24  3   -23 57 3    -23 61 3     -23 16 1
 -24 24  1   -24 57 3    -24 61 4 
 -25 24  8   -25 57 3    -25 61 4 
 -26 24  9   -26 57 3    -26 61 4 
 -27 24 11   -27 57 3    -27 61 3     -27 16 1
 -28 24  1   -28 57 3    -28 61 4 
 -29 24  8   -29 57 3    -29 61 4 
 -30 24  9   -30 57 3    -30 61 4 
 -31 24 13   -31 57 3    -31 61 3     -31 16 1
 -32 24 14   -32 57 3    -32 61 4
 -33 24 14   -33 57 3    -33 61 4
 -34 24 14   -34 57 3    -34 61 4
 -35 24 14   -35 57 3    -35 61 4
 -36 24 15   -36 57 3    -36 61 5
 -37 24 14   -37 57 3    -37 61 4
 -38 24 14   -38 57 3    -38 61 4
 -39 24 16   -39 57 3    -39 61 4
 -40 24 16   -40 57 3    -40 61 4
 -41 24 16   -41 57 3    -41 61 4
# Start selectivity estimate after specified age for LL fisheries
  -3  75 2
  -6  75 2
  -9  75 2
  -23 75 2
  -21 75 2
  -17 75 2
  -27 75 2
  -31 75 2
 -999 26 2    # Use age-based select but ages w similar sizes penalized so sim select
# 1 74 1      # Sets a generic penalty to stabilise db norm and logistic - uncomment if using these forms...

#-------------------------------------------------------------------------------  
#   Fishery groupings for tag return data
   -1 32  1
   -2 32  2
   -3 32  3
   -4 32  4
   -5 32  5
   -6 32  6
   -7 32  7
   -8 32  8
   -9 32  9
  -10 32 10
  -11 32 11
  -12 32 12
  -13 32 13
  -14 32 14
  -15 32 14
  -16 32 15
  -17 32 16 
  -18 32 17
  -19 32 18
  -20 32 18
  -21 32 19
  -22 32 20
  -23 32 21
  -24 32 22
  -25 32 23
  -26 32 23
  -27 32 24
  -28 32 25
  -29 32 26
  -30 32 26
  -31 32 27
  -32 32 28
  -33 32 29
  -34 32 30
  -35 32 31
  -36 32 32
  -37 32 33
  -38 32 34
  -39 32 35
  -40 32 36
  -41 32 37
# Turn on weighted spline for calculating maturity at age from length observations   
  2 188 2 		
# Start with fixed M-at-age
  2 109 0          # M-at-age from ini file, age_pars(2)
  
  1 12 0
  1 13 0
  1 14 0

PHASE1
fi
# ---------
#  PHASE 2 
# ---------
if [ ! -f 02.par ]; then
    ./mfclo64 skj.frq 01.par 02.par -file - <<PHASE2
    2 113 0        # Turns of rec_init_diff estimation
    1 1 500        # Sets no. of function evaluations for this phase
    1 50 -3        # convergence criterion is 1E+1
# Estimate movement coefficients   
  2 68 1         # Estimate movement parameters    
  2 69 1         # Use movement parameters
  2 27 -1   	 # Set penalty for movement coefficient to 0.1

PHASE2
fi
#
# ---------
#  PHASE 3
# ---------
if [ ! -f 03.par ]; then
    ./mfclo64 skj.frq 02.par 03.par -file - <<PHASE3
  2 70 1        # Estimate time-series changes in recruitment distribution
  2 71 1        # est. time series of reg recruitment
  2 178 1       # constraint on regional recruitments

PHASE3
fi
#
# ---------
#  PHASE 4
# ---------
if [ ! -f 04.par ]; then
    ./mfclo64 skj.frq 03.par 04.par -file - <<PHASE4
  #  Estimate regional distribution of recruitment           
  -100000 1 1                             
  -100000 2 1 
  -100000 3 1 
  -100000 4 1 
  -100000 5 1 
  -100000 6 1 
  -100000 7 1
  -100000 8 1 

PHASE4
fi
#
# ----------
#  PHASE 5
# ----------
if [ ! -f 05.par ]; then
    ./mfclo64 skj.frq 04.par 05.par -file - <<PHASE5
#  Dirichlet Multinomial (no random effects) settings
   1 141 11         # selects DM-noRE likelihood
   1 320 5          # implements tail compression
   1 342 5000       # maximum ESS
   -999 89 1        # Estimate relative sample size covariate
   -999 69 1        # Estimate exponent of sacalar of LF sample size multiplier
   -999 49 0        # Turn off RN sample size multiplier setting
# -- grouping flags for DM parameters (by gear type - PL/PS, ID/PH/VN, LL)
  -1 68  1 
  -2 68  1
  -3 68  2
  -4 68  1
  -5 68  1
  -6 68  2
  -7 68  1
  -8 68  1
  -9 68  2
 -10 68  3
 -11 68  3
 -12 68  3
 -13 68  1
 -14 68  1
 -15 68  1
 -16 68  3
 -17 68  2
 -18 68  1
 -19 68  1
 -20 68  1
 -21 68  2
 -22 68  1
 -23 68  2
 -24 68  1
 -25 68  1
 -26 68  1
 -27 68  2
 -28 68  1
 -29 68  1
 -30 68  1
 -31 68  2
 -32 68  1
 -33 68  1
 -34 68  1
 -35 68  1
 -36 68  3
 -37 68  1
 -38 68  1
 -39 68  1
 -40 68  1
 -41 68  1

PHASE5
fi
# ----------
#  PHASE 6
# ----------
if [ ! -f 06.par ]; then
    ./mfclo64 skj.frq 05.par 06.par -file - <<PHASE6
  1 1 1000          # How many function evaluations
  2 145 -1          # Penalty wt. for SRR  TEST SENSITIVITY - TRY USING 1 to -3
  2 146 1           # Make SRR parameters active
  2 147 1           # No. time periods for recruitment lag
  2 182 1 	    # Annualized recrutments and average biomass
  2 148 20          # Years (year quarters) from last year for avg. F  
  2 155 4           # But not including last 4
  1 149 0           # Turn off recruitment penalties against mean - frees up recruitment - should improve fit to compositions
  2 162 0           # Estimate steepness 0 IS THE DEFAULT   meaning not estimated
  2 163 0           # BH-SRR is parameterised using steepness. Value of 0 IS THE DEFAULT meaning it is parameterized with steepness
  2 199 148         # start time period for yield calculation [4.5.11], made consistent with 2014 assessment - starts in 1982
  2 200 4           # end time period for yield calculation [4.5.11]
  -999 55 1         # Turn off fisheries for impact analysis [4.5.14]
  2 193 1           # Turn on fisheries impact analyses
  2 171 1           # Unfished calculations by estimated SRR
  2 161 1           # Turn on the bias correction for the Beverton-Holt
  2 116 200         # Increase Z bound for NR computations to 2.0
  1 190 1           # Write plot.rep
  1 186 1           # Write fishmort and plotq0.rep
  1 187 1           # Write temporary_tag_report
  1 188 1           # Write ests.rep
  1 189 1           # Write .fit files

PHASE6
fi
# ----------
#  PHASE 6a         # Estimating growth parameters
# ----------
if [ ! -f 06a.par ]; then
    ./mfclo64 skj.frq 06.par 06a.par -file - <<PHASE6a
    1 13 1          # Estimate L2 and K
    1 14 1
PHASE6a
fi
# ----------
#  PHASE 6b
# ----------
if [ ! -f 06b.par ]; then
    ./mfclo64 skj.frq 06a.par 06b.par -file - <<PHASE6b
    1 12 1          # Estimate L1
PHASE6b
fi
# ----------
#  PHASE 6c
# ----------
if [ ! -f 06c.par ]; then
    ./mfclo64 skj.frq 06b.par 06c.par -file - <<PHASE6c
    1 15 1          # Estimate SD
    1 16 1          # Estimate length-dependent SD
PHASE6c
fi
# ----------
#  PHASE 7
# ----------
if [ ! -f 07.par ]; then
    ./mfclo64 skj.frq 06c.par 07.par -file - <<PHASE7
  2 109 2           # Activate M splines 
  1 121 5           # Set number of nodes to 5

PHASE7
fi
# ----------
#  PHASE 8
# ----------
if [ ! -f 08.par ]; then
    ./mfclo64 skj.frq 07.par 08.par -file - <<PHASE8
  2 116 300         # Further relax the bound on Z
  1 50 -6           # Convergence criteria - if achieved phase will terminate before full no. evaluations made
  1 1 20000         # How many function evaluations

PHASE8
fi
# ----------
#  PHASE 9
# ----------
if [ ! -f 09.par ]; then
    ./mfclo64 skj.frq 08.par 09.par -file - <<PHASE9
#-------------------------------------------------------------------------------
# - fishing mortality level : observed effort relationship - for fisheries needed for projections
  1 377 1         # activate fm:effort fit
  1 378 3         # student-t option for the fm:effort fit relationship CCJ before was 0, if option 3 (t-student) is used, must to activate -999 93 1
  1 383 10        # weight for normal penalty on implicit_fm_level_regression_pars. I think 10 -> CV = 0.22
# PS fisheries, estimate regression coefficients
  -8 93 1  -8 73 7   # PS R3
 -14 93 1 -14 73 7   # PS ASS R5
 -15 93 1 -15 73 7   # PS UNA R5
 -19 93 1 -19 73 7   # PS ASS R6
 -20 93 1 -20 73 7   # PS UNA R6
 -25 93 1 -25 73 7   # PS ASS R7
 -26 93 1 -26 73 7   # PS UNA R7
 -29 93 1 -29 73 7   # PS ASS R8
 -30 93 1 -30 73 7   # PS UNA R8
# LL fisheries, no effort no estimation
  -3 93 0  -3 73 0
  -6 93 0  -6 73 0
  -9 93 0  -9 73 0
 -17 93 0 -17 73 0
 -21 93 0 -21 73 0
 -23 93 0 -23 73 0
 -27 93 0 -27 73 0
 -31 93 0 -31 73 0
# Other fisheries with effort, estimate a constant q
  -1 93 1  -1 73 0
  -2 93 1  -2 73 0
  -4 93 1  -4 73 0
  -5 93 1  -5 73 0
  -7 93 1  -7 73 0
 -10 93 1 -10 73 0
 -11 93 1 -11 73 0
 -12 93 1 -12 73 0
 -13 93 1 -13 73 0
 -16 93 1 -16 73 0
 -18 93 1 -18 73 0
 -22 93 1 -22 73 0
 -24 93 1 -24 73 0
 -28 93 1 -28 73 0
# Survey fisheries not estimated
 -32 93 0 -32 73 0
 -33 93 0 -33 73 0
 -34 93 0 -34 73 0
 -35 93 0 -35 73 0
 -36 93 0 -36 73 0
 -37 93 0 -37 73 0
 -38 93 0 -38 73 0
 -39 93 0 -39 73 0
 -40 93 0 -40 73 0
 -41 93 0 -41 73 0

PHASE9
fi
