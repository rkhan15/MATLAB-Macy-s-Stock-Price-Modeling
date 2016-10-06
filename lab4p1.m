%% Raiha Khan, MATH 227-003, Lab 4, 10/6/2016

%% Introduction

% Assignment: Let Si be the adjust close price on day i, and define Xi = ln(Si/Si?1), which is known as the continuously
% compounded rate of return on day i. Calculate the mean ? and variance ?^2 for the dataset {X}.

% The return of a stock price process S(t) is modeled by the stochastic differential equation: 
% dSt/St = µdt + ?dWt

% Solution for this SDE: St = S0 * e^ [(µ ? ?^2 /2)t + ?Wt

% Sn+1 = Sn * e^ [h(µ ? ?^2 /2) + ?N (µ = 0, ? = ? h)]

% The array Xn is defined as Xn = ln(Sn/Sn?1), which is known as the continuously compounded rate of return.

%% Analysis

% Using data from Macy's stocks

h = 1/253; % one trading day
S = flipud(AdjClose); % array of adjust close price values
X = zeros(1,length(S));
sum = 0;


for i = 2:253
    X(i) = log(S(i) ./ S(i-1)); % continuously compounded rate of return on day i
    sum = sum + X(i);
end

nu = mean(X)
tau = std(X)

sigma = tau / sqrt(h)
mu = nu/h + (tau^2)/(2*h)

R = 10000; % # of realizations
S_0 = AdjClose(end); % Assigns last value of AdjClose to a variable S_0

price_final = zeros(1, R); % Creates an array of zeroes to be filled with new final values at each realization

for k = 1:R
    S_new = zeros(1, 253);
    S_new(1) = S_0;
    
    for m = 1:252 % This loop models behavior of Macy's stock prices over the next year using the stochastic differential equation   
        S_new(m+1) = S_new(m)*exp(h*(mu-sigma^2/2) + sigma * normrnd(0, sqrt(h)));
    end
        
    price_final(k) = S_new(253); % Assigns last price value at this realization to the index of price_value at this realization
end

mean(price_final > S_0 * 1.1) % Computes the mean of all values of price_value that are greater than 10% of S_0

%% Conclusion

% I obtained the Historical Data for Macy’s (M) from Sep. 29, 2015 to Sep. 29, 2016. After using a loop to generate the values for the array X, 
% I calculated the mean (nu) and the variance (tau) for X. 

% To find the probability of Macy’s stock price increasing by 10%, I had to model the behavior of Macy’s stock prices over the next year using the 
% SDE indicated in my introduction. I ran 10,000 realizations to form a distribution about the final value of the stock on September 28, 2017, and 
% I found the mean of the values of price_final that exceeded 10% of the ending value on September 29, 2017. The mean came out to be 0.1628, which 
% indicates that the probability of the stock price increasing by 10% after 253 trading days is 16.28%. 