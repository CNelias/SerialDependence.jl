using Statistics

"""
Returns the lagged bivariate probability of two given categories, Pij.
Given i and j two categories, and l a lag,
Pij is the probability to have the category j at time t + l, if we have i at time t.

    inputs :
    - time series : the data to analyse
    - lag : the value of lag at which one wants Pij
    - category1 : the first category
    - category2 : the second category

    output :
    - Pij : the probability the observe j at t + l if we observe i at time t.

"""

function LaggedBivariateProbability(TimeSerie, Lag::Int, Category1, Category2)
    Pij = 0
    lagged_serie_length = length(TimeSerie) - Lag
    for i in 1:lagged_serie_length
        if (TimeSerie[i] == Category1) && (TimeSerie[i + Lag] == Category2)
            Pij += 1/(lagged_serie_length)
        end
    end
    return Pij
end

"""
Computes the lagged bivariate probability, Pij, for the given Array of Lag values, and returns an array.
See LaggedBivariateProbability(TimeSerie, Lag::Int, Category1, Category2).

    inputs :
    - time series : the data to analyse.
    - Lags : an array of lags containing the different lag values at which one wants
             to carry the analysis.
    - category1 : the first category.
    - category2 : the second category.

    output :
    - Pij : Array of lagged bivariate probabilities for the given lags.

"""

function LaggedBivariateProbability(TimeSerie, Lags, Category1, Category2)
    Pij = [LaggedBivariateProbability(TimeSerie,L,Category1,Category2) for L in Lags]
    return Lags,Pij
end

"""
Returns the relative frequency of a given category (of type ::Any).
For example, if we have 3 category a,b and c, and a occurs 300 times in a time series of length 900,
its relative frequency  is 1/3.

"""
function relative_frequency(TimeSerie, Category::Any)
    Pi = 0
    for i in TimeSerie
        if i == Category
            Pi += 1/length(TimeSerie)
        end
    end
    return Pi
end

function cohen_coefficient(Serie, Lag::Int64, Categories)
    K = 0
    pi_denominateur = 0
    for i in Categories
        K += (LaggedBivariateProbability(Serie,Lag,i,i) -  relative_frequency(Serie,i)^2)
        pi_denominateur =+ relative_frequency(Serie,i)^2
    end
    K = K/(1-pi_denominateur)
    return K
end

function cohen_coefficient(Serie, Lags::Array{Int64,1}, Categories)
    K = [cohen_coefficient(Serie,l,Categories) for l in Lags]
    return Lags,K
end


"""
Returns the value of the cramer's V coefficient for the given categories in the given time series.
It is a measurement of the correlations between these category, it's value lies in [0,1], 0 being : no correlation
1 being strong correlations.
V is symmetric, meaning v(A,B) = v(B,A), so the information contained in the asymmetry between the variables is lost.

    input :
    - Serie : the time series containing the data
    - Lags : Array containing the lags at which V will be computed
    - Categories : the categories to be taken in account. should be an
                   array of two value for a precise analysis, more for a global
                   Analysis
    output :
    - V : the values of v for the given lags.

"""
function cramer_coefficient(Serie,Lags::Array{Int64,1},Categories)
    V = Float64[]
    for lag in Lags
        v = 0
        for i in Categories
            for j in Categories
                v =+ ((LaggedBivariateProbability(Serie,lag,i,j)-relative_frequency(Serie,i)*relative_frequency(Serie,j))^2)/(relative_frequency(Serie,i)*relative_frequency(Serie,j))
            end
        end
        append!(V,sqrt(v/(length(Categories)-1)))
    end
    return Lags,V
end
