/*Harmonised RGSC over censuses 

This code only covers people who have a valid RGSC code (i.e. not a negative value).
All negative values are set to missing. This is because:
	- other categories are harder to harmonise
	- the scheme used would depend on the project aim

*Variables needed:
	socc7 (ME71)
	soc8 (ME81)
	sclas9 (ME91)
	sclas0 (ME01)
	rgsc11 (ME11)

Open the dataset that you want to add the derived variable/s to, and make sure
that it has all the variables that are in the variables list above).

Change your working directory to your project area*/
cd "P:\......" 
***********************************************************************************

/*1971 (socc7) (0 = I Professional; 1 = II Intermediate; 2 = IIIN Skilled Non-Manual;
3 = IIIM Skilled Manual; 4 = IV Partly Skilled; 5 = V Unskilled; 6 = Armed Forces;
-1 = student or child; -2 = Other inactive; -9 = Missing)*/
generate socialclass71 = socc7+1
replace socialclass71=. if socc7<0
label define soc 1 "I Professional" 2 "II Intermediate" 3 "IIIN Skilled Non-Manual" 4 "IIIM Skilled Manual" 5 "IV Partly Skilled" 6 "V Unskilled" 7 "Armed Forces" , replace
label values socialclass71 soc
label variable socialclass71 "Social Class 1971"
tab socialclass71

/*1981 (soc8) (0 = I Professional; 1 = II Intermediate; 2 = IIIN Skilled Non-Manual;
3 = IIIM Skilled Manual; 4 = IV Partly Skilled; 5 = V Unskilled; 7 = Armed Forces;
8 = Inadequately described; 9 = Student/ no occupation because permanently sick or
disabled, housewife; -9 = Not applicable or no 1981 record)*/
generate socialclass81=soc8+1
replace socialclass81=7 if soc8==7
replace socialclass81=. if soc8==8 | soc8==9 | soc8<0
label define soc 1 "I Professional" 2 "II Intermediate" 3 "IIIN Skilled Non-Manual" 4 "IIIM Skilled Manual" 5 "IV Partly Skilled" 6 "V Unskilled" 7 "Armed Forces" , replace
label values socialclass81 soc
label variable socialclass81 "Social Class 1981"

/*1991 (sclas9) (1 = I Professional occupations; 2 = II Managerial and technical 
occupations; 3 = IIIN Skilled Non-Manual occupations; 4 = IIIM Skilled manual occupations;
5 = IV Partly Skilled; 6 = V Unskilled; 7 = Armed Forces; 8 = Inadequately described;
9 = Not stated; -9 = Not applicable or missing)*/
generate socialclass91 = sclas9
replace socialclass91=. if sclas9==8 | sclas9==9 | sclas9==-9
label define soc 1 "I Professional" 2 "II Managerial and technical" 3 "IIIN Skilled Non-Manual" 4 "IIIM Skilled Manual" 5 "IV Partly Skilled" 6 "V Unskilled" 7 "Armed Forces" , replace
label values socialclass91 soc
label variable socialclass91 "Social Class 1991"

/*2001 (sclas0) (1 = I Professional occupations; 2 = II Managerial and technical 
occupations; 3 = IIIN Skilled Non-Manual occupations; 4 = IIIM Skilled manual occupations;
5 = IV Partly Skilled; 6 = V Unskilled; 7 = Armed Forces; 8 = Occupation inadequately
described; -9 = Not classified - occupation code or employment status not available;
-6 = Initial extract only)*/
generate socialclass01=sclas0
replace socialclass01=. if sclas0==8 | sclas0==-6 | sclas0==-9, 
label define soc 1 "I Professional" 2 "II Managerial and technical" 3 "IIIN Skilled Non-Manual" 4 "IIIM Skilled Manual" 5 "IV Partly Skilled" 6 "V Unskilled" 7 "Armed Forces" , replace
label values socialclass01 soc
label variable socialclass01 "Social Class 2001"

/*2011 (rgsc11) (10 = Professional etc. occupations; 20 = Managerial and technical 
occupations; 31 = Skilled occupations - Non-Manual; 32 = Skilled occupations - manual;
40 = Partly Skilled; 50 = Unskilled occupations; 60 = Armed forces; -9 = Not applicable
(aged under 16, students not at their term time address, Never worked, Long-term u/e,
full-time students); -6 = Missing)*/
generate socialclass11 = rgsc11
replace socialclass11=. if rgsc11==-6 | rgsc11==-9, 
recode socialclass11 10=1 20=2 31=3 32=4 40=5 50=6 60=7
label define soc 1 "I Professional" 2 "II Intermediate" 3 "IIIN Skilled Non-Manual" 4 "IIIM Skilled Manual" 5 "IV Partly Skilled" 6 "V Unskilled" 7 "Armed Forces" , replace
label values socialclass11 soc
label variable socialclass11 "Social Class 2011"

tab socialclass71
tab socialclass81
tab socialclass91
tab socialclass01
tab socialclass11
********************************************************************************

/*The same code can be used for the non-members files, but you will need to replace
socc7, soc8, sclas9, sclas0, rgsc11 with nsocc7, nsoc8, nsclas9, nsclas0, nrgsc11.*/