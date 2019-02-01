using Statistics

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

function LaggedBivariateProbability(TimeSerie, Lags::Array{Any,1}, Category1, Category2)
    Pij = Float64[]
    for L in Lags
        p = 0
        lagged_serie_length = length(TimeSerie) - L
        for i in 1:lagged_serie_length
            if (TimeSerie[i] == Category1) && (TimeSerie[i+L] == Category2)
                p += 1/(lagged_serie_length)
            end
        end
        append!(Pij, p)
    end
    return Pij
end


function RelativeFrequency(TimeSerie, Category)
    Pi = 0
    for i in TimeSerie
        if i == Category
            Pi += 1/length(TimeSerie)
        end
    end
    return Pi
end

function CohenCoefficient(Serie, Lag::Int64, Categories)
    K = 0
    pi_denominateur = 0
    for i in Categories
        K += (LaggedBivariateProbability(Serie,Lag,i,i) -  RelativeFrequency(Serie,i)^2)
        pi_denominateur =+ RelativeFrequency(Serie,i)^2
    end
    K = K/(1-pi_denominateur)
    return K
end

function CohenCoefficient(Serie, Lag::Array{Int64,1}, Categories)
    K = Float64[]
    for lag in Lag
        k = 0
        pi_denominateur = 0
        for i in Categories
            k += (LaggedBivariateProbability(Serie,lag,i,i) -  RelativeFrequency(Serie,i)^2)
            pi_denominateur =+ RelativeFrequency(Serie,i)^2
        end
    append!(K, k/(1-pi_denominateur))
    end
    return K
end

function CramerCoefficient(Serie,Lag::Array{Int64,1},Categories)
    V = Float64[]
    for lag in Lag
        v = 0
        for i in Categories
            for j in Categories
                v =+ ((LaggedBivariateProbability(Serie,lag,i,j)-RelativeFrequency(Serie,i)*RelativeFrequency(Serie,j))^2)/(RelativeFrequency(Serie,i)*RelativeFrequency(Serie,j))
            end
        end
        append!(V,sqrt(v/(length(Categories)-1)))
    end
    return V
end
