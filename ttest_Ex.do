* This is an example of how to conduct a t-test in Stata


**** construct data ************************************************************
* First, we need to generate some fake data for our example

* clear working space:
clear all

* set a seed for reproducibility:
set seed 12345

* create two random variables, N(3,1) and N(2.8,0.5^{1/2})
drawnorm var1, n(200) mean(3) sd(1)
drawnorm var2, n(200) mean(2.8) sd(0.5)

* save the data
save ".\dummydata.dta", replace
**** end data construction *****************************************************



**** T-tests for one RV ********************************************************
* clear working space
clear all

*load data set
use ".\dummydata.dta", clear

* Run a t-test for the first rv having a mean of 3.25:
ttest var1 == 3.25
* the t-statistic is -2.519 -- so it seems pretty unlikely we would have drawn this sample if the null hypothesis were correct!
* The 2-sided p-value is 0.0126, suggesting that it is very unlikely the mean of the true distribution is 3.25
* P-value of 0.0126 means we can reject the null at the 5% significance level.

* If we had tested against a mean of 3.2:
ttest var1 == 3.2
* Then the p-value of the two sided test is 0.0683, meaning we fail to reject the null at the 5% significance level.
* However, the p-value of the test of the one-sided hypothesis that the true mean is >= 3.2 is 0.0342, meaning that we can reject that null at 5% significance level

* Question: why is it easier to reject the one-sided hypothesis than the two sided?

********************************************************************************



**** T-tests for two RVs *******************************************************
* Now we can compare the mean of var1 against that of var2
ttest var1 == var2
* the t-statistic is 2.89
* the 2-sided p-value is 0.0043, so we can reject the null that the means are equal at the 5% significance level

* What is the 1-sided hypothesis saying in this context?

* What if we wanted to test that the difference is equal to some integer?

* Construct a new variable which is equal to the difference
gen var3 = var1 - var2

* check ttest for mean 0 gives same results as above
ttest var3 == 0

* OK; now we can test if the difference in means is equal to 0.5 
ttest var3 == 0.5
* Can reject at the 5% level; so 0 was too small and 0.5 was too big

* Plug in what we know is thre true value:
ttest var3 = 0.2
* results look good.
**** End t-test for two RVs ****************************************************




