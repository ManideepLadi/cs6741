### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ ba3fecd8-740e-11eb-220f-ff631294f43c
using PlutoUI

# ╔═╡ d77eb714-740e-11eb-20d0-29e37b575812
begin
	using Plots
	pyplot()
end

# ╔═╡ 68287b72-7411-11eb-1a3a-8b04256bc228
using Distributions

# ╔═╡ f14679d4-740e-11eb-0155-c54cdfef8a7e
function stockMarket(prob)
	num=100000
	dict=Dict()
	for i in 1:num
		money=10
		for j in 1:20
			x=rand(1:100)
			if x<=(prob)
				money=money+1
			else 
				money=money-1
			end
		end
		if get(dict,money,0)==0
			dict[money]=1
		else
			dict[money]=dict[money]+1
		end
	end
	for i in keys(dict) 
    	dict[i]=dict[i]/num
	end
	probabiltyOfAtleast10=0
	for i in keys(dict) 
		if i>=10
			probabiltyOfAtleast10=probabiltyOfAtleast10+dict[i]
		end
	end
	return probabiltyOfAtleast10
end

# ╔═╡ fc29552e-740e-11eb-2def-f13816140a44
function simulation()
	probabilityArray=[]
	empty!(probabilityArray)
	for prob in 1:100
		push!(probabilityArray,stockMarket(prob))
	end
	return probabilityArray
end

# ╔═╡ 07946a7a-740f-11eb-1d80-771083cdf735
emphricalProbabilites=simulation()

# ╔═╡ 16e3adce-740f-11eb-38f4-f5b46562e64f
begin
	plot(1:100,emphricalProbabilites, legend=false,xlabel="0.01p",ylabel="ProbabilityOfAtleast10")
	scatter!(1:100,emphricalProbabilites,legend=false)
end

# ╔═╡ eb2c21c4-7411-11eb-070b-c1f79c81ac22
function theoriticalStockMarket(p)
	binomialDistribution=Distributions.Binomial(20,p/10)
	theoriticalValues=pdf(binomialDistribution)
	theoriticalProbability=0  
	for i in 11:length(theoriticalValues)
    	theoriticalProbability += theoriticalValues[i]
	end
	return theoriticalProbability
end

# ╔═╡ c5049032-7412-11eb-3564-7707b441300b
function theoritical()
	theoriticalprobabilityArray=[]
	empty!(theoriticalprobabilityArray)
	for prob in 1:10
		push!(theoriticalprobabilityArray,theoriticalStockMarket(prob))
	end
	return theoriticalprobabilityArray
end

# ╔═╡ 0ceb7280-7413-11eb-103d-d1887c106e0c
theoreticalValues=theoritical()

# ╔═╡ 041bb7fa-7413-11eb-29fd-fd9eaa423c74
begin
	plot(1:10,theoreticalValues, legend=false,xlabel="0.1p",ylabel="ProbabilityOfAtleast10")
	scatter!(1:10,theoreticalValues,legend=false)
end

# ╔═╡ Cell order:
# ╠═ba3fecd8-740e-11eb-220f-ff631294f43c
# ╠═d77eb714-740e-11eb-20d0-29e37b575812
# ╠═f14679d4-740e-11eb-0155-c54cdfef8a7e
# ╠═fc29552e-740e-11eb-2def-f13816140a44
# ╠═07946a7a-740f-11eb-1d80-771083cdf735
# ╠═16e3adce-740f-11eb-38f4-f5b46562e64f
# ╠═68287b72-7411-11eb-1a3a-8b04256bc228
# ╠═eb2c21c4-7411-11eb-070b-c1f79c81ac22
# ╠═c5049032-7412-11eb-3564-7707b441300b
# ╠═0ceb7280-7413-11eb-103d-d1887c106e0c
# ╠═041bb7fa-7413-11eb-29fd-fd9eaa423c74
