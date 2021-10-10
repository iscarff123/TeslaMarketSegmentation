
/*
Ian Scarff
iie728

Practicum I
Market Segmentation Project
/*

/* 
I am going to imagine that I am Tesla. My company has been developing a new family car 
with all the latest technologies and want to advertise it. 
My goal is to identify people who are family centered and 
who are into cars like Teslas.
*/

/* My target population is the U.S. adult population for 18 years of age or older. */

/* Drivers
Construct 1: Family Centered
	Question 1: Family life is the most important thing to me.
	Question 2: I like to provide my children with things that I didn't have as a child.
	Question 3: I like spending most of my time at home with my family.
	Question 4: I enjoy spending time with my family.

Construct 2: People who want nice cars
	Question 1: I prefer driving luxury cars.
	Question 2: I normally buy brand new cars.
	Question 3: The technologies offered in a car’s dashboard influences my decision to buy it.
	Question 4: I choose a car mainly on the basis of looks
*/

/*
Cluster Variables:
	Variable 1: Advertising helps me learn about the products companies have to offer.
	Variable 2: I love to buy new gadgets and appliances.
	Variable 3: I am worried about pollution and congestion caused by cars.
	Variable 4: I am more likely to purchase products I see advertised on a social media/networking
				website.
*/

/* Descriptor Variables:
Variable 1: Race
Variable 2: Watch ESPN in last 7 days.
Variable 3: Next Vehicle: Used or New
Variable 4: Chick-fil-a in last 30 days
*/




/* Go get variables */
filename rawData 'O:\Student$\MSDA2020\MKT6971_003\Instructor\FA15_Data.txt'
lrecl=65378;

/* Grab the Driver variables */
data rawDrivers;
infile rawData;
input myid 1-7

/*Family life is the most important thing to me.*/
familyLife_agree_alot 4680
familyLife_agree_little 4757
familyLife_neither 4911
familyLife_disagree_little 4988
familyLife_disagree_alot 5065

/*I like to provide my children with things that I didn't have as a child.*/
provide_agree_alot 4649
provide_agree_little 4726
provide_neither 4880
provide_disagree_little 4957
provide_disagree_alot 5034

/*I like spending most of my time at home with my family.*/
familyHome_agree_alot 4636
familyHome_agree_little 4713
familyHome_neither 4867
familyHome_disagree_little 4944
familyHome_disagree_alot 5021

/*I enjoy spending time with my family.*/
familyTime_agree_alot 4610
familyTime_agree_little 4687
familyTime_neither 4841
familyTime_disagree_little 4918
familyTime_disagree_alot 4995

/*I prefer driving luxury cars.*/
luxury_agree_alot 3617
luxury_agree_little 3653
luxury_neither 3725
luxury_disagree_little 3761
luxury_disagree_alot 3797

/*I normally buy brand new cars.*/
new_agree_alot 3620
new_agree_little 3656
new_neither 3728
new_disagree_little 3764
new_disagree_alot 3800

/*The technologies offered in a car’s dashboard influences my decision to buy it.*/
tech_agree_alot 3632
tech_agree_little 3668
tech_neither 3740
tech_disagree_little 3776
tech_disagree_alot 3812


/*I choose a car mainly on the basis of looks.*/
carLooks_agree_alot 3619
carLooks_agree_little 3655
carLooks_neither 3727
carLooks_disagree_little 3763
carLooks_disagree_alot 3799;
run;


/* Now clean up the driver variables */

/* use an array to convert missing values to zeros */
data DriverCleaning;
set rawDrivers;
array missing (8,5)
familyLife_agree_alot
familyLife_agree_little
familyLife_neither
familyLife_disagree_little
familyLife_disagree_alot
provide_agree_alot
provide_agree_little
provide_neither 
provide_disagree_little
provide_disagree_alot 
familyHome_agree_alot
familyHome_agree_little 
familyHome_neither 
familyHome_disagree_little 
familyHome_disagree_alot 
familyTime_agree_alot 
familyTime_agree_little
familyTime_neither
familyTime_disagree_little
familyTime_disagree_alot
luxury_agree_alot
luxury_agree_little
luxury_neither
luxury_disagree_little
luxury_disagree_alot
new_agree_alot
new_agree_little
new_neither
new_disagree_little
new_disagree_alot
tech_agree_alot
tech_agree_little
tech_neither
tech_disagree_little
tech_disagree_alot
carLooks_agree_alot
carLooks_agree_little
carLooks_neither
carLooks_disagree_little
carLooks_disagree_alot;

/* Convert missing values to zeros */
do i = 1 to 8;
	do j = 1 to 5;
		if missing(i,j) = . then missing(i,j) = 0;
	end;
end;

/* Make an array for 8 variable sums */
array mysum (8);

/*Make each variable, being sure to ignore zeroes and > 1*/
do k = 1 to 8;
	mysum(k) = missing(k,1) + missing(k,2) + missing(k,3) + missing(k,4) + missing(k,5);
end;

/*Now if the variable is not zero or > 1 create var */
array myvar(8);
do m = 1 to 8;
	if mysum(m) = 1 then
		myvar(m) = (missing(m,1)*5) + (missing(m,2)*4) + (missing(m,3)*3) + (missing(m,4)*2) + (missing(m,5)*1);
	else
		myvar(m) = .;
end;

/* Now make variable names pretty again*/
familyLife = myvar(1);
provide = myvar(2);
familyHome = myvar(3);
familyTime = myvar(4);
luxury = myvar(5);
new = myvar(6);
tech = myvar(7);
carLooks = myvar(8);
run;

/* Keep only the neccesary variables and give them labels */
data drivers;
set DriverCleaning;
keep myid familyLife provide familyHome familyTime luxury new tech carLooks;

label familyLife = "Family life is the most important thing to me.";
label provide = "I like to provide my children with things that I didn't have as a child.";
label familyHome = "I like spending most of my time at home with my family.";
label familyTime = "I enjoy spending time with my family.";
label luxury = "I prefer driving luxury cars.";
label new = "I normally buy brand new cars.";
label tech = "The technologies offered in a car’s dashboard influences my decision to buy it.";
label carLooks = "I choose a car mainly on the basis of looks.";
run;



/* Now go grab the variables for clustering */
data rawClusters;
infile rawData;
input myid 1-7

/*Advertising helps me learn about the products companies have to offer.*/
advLearn_agree_alot 5780
advLearn_agree_little 5825
advLearn_neither 5915
advLearn_disagree_little 5960
advLearn_disagree_alot 6005

/* I love to buy new gadgets and appliances */
gadgets_agree_alot 6954
gadgets_agree_little 6971
gadgets_neither 7005
gadgets_disagree_little 7022
gadgets_disagree_alot 7039


/* I am worried about pollution and congestion caused by cars. */
pollu_agree_alot 4193
pollu_agree_little 4207
pollu_neither 4235
pollu_disagree_little 4249
pollu_disagree_alot 4263

/* I am more likely to purchase products I see advertised on a social media/networking website.*/
advSocialMedia_agree_alot 6845
advSocialMedia_agree_little 6860
advSocialMedia_neither 6890
advSocialMedia_disagree_little 6905
advSocialMedia_disagree_alot 6920;
run;


/* Now clean up the clustering variables */

/* use an array to convert missing values to zeros */
data ClustersCleaning;
set rawClusters;
array missing (4,5)
advLearn_agree_alot
advLearn_agree_little
advLearn_neither
advLearn_disagree_little
advLearn_disagree_alot
gadgets_agree_alot
gadgets_agree_little
gadgets_neither
gadgets_disagree_little
gadgets_disagree_alot
pollu_agree_alot
pollu_agree_little
pollu_neither
pollu_disagree_little
pollu_disagree_alot
advSocialMedia_agree_alot
advSocialMedia_agree_little
advSocialMedia_neither
advSocialMedia_disagree_little
advSocialMedia_disagree_alot;

/* Convert missing values to zeros */
do i = 1 to 4;
	do j = 1 to 5;
		if missing(i,j) = . then missing(i,j) = 0;
	end;
end;

/* Make an array for 5 variable sums */
array mysum (5);

/*Make each variable, being sure to ignore zeroes and > 1*/
do k = 1 to 4;
	mysum(k) = missing(k,1) + missing(k,2) + missing(k,3) + missing(k,4) + missing(k,5);
end;

/*Now if the variable is not zero or > 1 create var */
array myvar(4);
do m = 1 to 4;
	if mysum(m) = 1 then
		myvar(m) = (missing(m,1)*5) + (missing(m,2)*4) + (missing(m,3)*3) + (missing(m,4)*2) + (missing(m,5)*1);
	else
		myvar(m) = .;
end;

/* Now make variable names pretty again*/
advLearn = myvar(1);
gadgets = myvar(2);
pollution = myvar(3);
advSocialMedia = myvar(4);
run;

data Clusters;
set ClustersCleaning;
keep myid advLearn gadgets pollution advSocialMedia;

label advLearn = "Advertising helps me learn about the products companies have to offer.";
label gadgets = "I love to buy new gadgets and appliances.";
label pollution = "I am worried about pollution and congestion caused by cars.";
label advSocialMedia = "I am more likely to purchase products I see advertised on a social media/networking website.";
run;


/* Now grab Descripter variables */
data rawDescripters;
infile rawData;
input myid 1-7

/*Race */
Racewhite 2420
Raceblack 2421
Raceasian 2422
Raceother 2423

/* Watch ESPN in last 7 days */
espn 9625

/* Next Vehicle*/
nextNew 64921
nextUsed 64922

/* Visited Chick-Fil-A  */
chickfila 41753;
run;


/* Now clean up Descripter variables */
data DiscriptersCleaning;
set rawDescripters;
	
/*Race */
if Racewhite = . then RaceWhite = 0;
if Raceblack = . then Raceblack = 0;
if Raceasian = . then Raceasian = 0;
if Raceother = . then Raceother = 0;

/* Watch ESPN in last 7 days */
if espn = . then espn = 0;

/* Next Vehicle*/
if nextNew = 1 then NextVehicle = 1;
if nextUsed = 1 then NextVehicle = 0;

/* Visited Chick-Fil-A */
if chickfila = . then chickfila = 0;

run;

data Descripters;
set DiscriptersCleaning;
keep myid Raceasian Raceblack Raceother Racewhite NextVehicle chickfila espn;

label Raceasian = "Race = Asian";
label Raceblack = "Race = Black";
label Racewhite = "Race = White";
label Raceother = "Race = Other";
label NextVehicle = "Next vehicle is new or used?";
label chickfila = "Visited Chick-Fil-A";
label espn = "Watch ESPN in the last 7 days?";
run;


/* Join tables around my_id. Sort them first */


proc sort data=Drivers;
by myid;
proc sort data=Clusters;
by myid;
proc sort data=Descripters;
by myid;

data DATA;
merge  Drivers Clusters Descripters;
by myid;
run;


/* Create various formats */
proc format;
value GenderScale 0 = "Male"
				  1 = "Female";
run;

proc format;
value fivescale 5 = "agree alot"
				4 = "agree a little"
				3 = "neither agree nor disagree"
				2 = "disagree a little"
				1 = "disagree alot";
run; 

proc format;
value Binaryscale 0 = "No"
				  1 = "Yes";
run;

proc format;
value NewUsedScale 0 = "Used"
				   1 = "New";
run;


/* Create frequency tables for all variables */

proc freq data=DATA;
format Raceasian Raceblack Raceother Racewhite chickfila espn Binaryscale.;
format familyLife provide familyHome familyTime luxury new tech carLooks advLearn gadgets pollution advSocialMedia familyCar purchaseDec fivescale.;
format NextVehicle NewUsedScale.;
tables familyLife provide familyHome familyTime luxury new tech carLooks advLearn gadgets pollution advSocialMedia Raceasian Raceblack Raceother Racewhite NextVehicle chickfila espn;
run;



/* Now run PCA on the two constructs */
proc factor data = DATA
	maxiter = 100
	method = principal
	mineigen = 1
	rotate = varimax
	scree
	score
	print;
	var familyLife provide familyHome familyTime luxury new tech carLooks;
run;

/* Two factors are optimal */
/* Output data */
proc factor data = DATA out=DATA2 nfactors=2
	maxiter = 100
	method = principal
	mineigen = 1
	rotate = varimax
	scree
	score
	print;
	var familyLife provide familyHome familyTime luxury new tech carLooks;
run;



/* Now run cluster analysis */
proc fastclus data=DATA2 maxclusters=2;
var advLearn gadgets pollution advSocialMedia Factor1;
proc fastclus data=DATA2 maxclusters=3;
var advLearn gadgets pollution advSocialMedia Factor1;
proc fastclus data=DATA2 maxclusters=4;
var advLearn gadgets pollution advSocialMedia Factor1;
proc fastclus data=DATA2 maxclusters=5;
var advLearn gadgets pollution advSocialMedia Factor1;
proc fastclus data=DATA2 maxclusters=6;
var advLearn gadgets pollution advSocialMedia Factor1;
proc fastclus data=DATA2 maxclusters=7;
var advLearn gadgets pollution advSocialMedia Factor1;
run;

/* K-means clustering says 4 clusters*/



/* Now run GAP analysis */
proc hpclus data=DATA2 maxclusters=7
noc=abc(b=20 minclusters=2 align=pca criterion=firstpeak);
Score out=mycluster;
input advLearn gadgets pollution advSocialMedia Factor1 / level=interval;
id myid;
run;


/* GAP says 2. Go with 4 */
/* 4 clusters are optimal */


proc fastclus data=DATA2 maxclusters=4 out=myclus;
var advLearn gadgets pollution advSocialMedia Factor1;
run;

/* Run means on descriptors */ 
proc sort data=myclus; 
by cluster;
proc means data=myclus;
var Raceasian Raceblack Raceother Racewhite NextVehicle chickfila espn;
by cluster;
run;











