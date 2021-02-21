### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 219e787a-7416-11eb-191f-3d7b41d51534
using PlutoUI

# ╔═╡ 27ab921e-7416-11eb-39a4-51d5fd893aaf
begin
	using Plots
	pyplot()
end

# ╔═╡ e8465616-741c-11eb-3617-9b254d8780d5
using Distributions

# ╔═╡ 27ab6fa0-7416-11eb-1498-39f64c0d4258
function probabilityWithoutBankrupt(prob)
	dict1=Dict()
	num=100000
	for i in 1:num
		money=10
		isbankrupted=false
		for j in 1:20
			x=rand(1:100)
			if x<=(prob)
				money=money+1
			else 
				money=money-1
			end
			if money<=0
				isbankrupted=true
			end
		end
		if !isbankrupted
				if get(dict1,money,0)==0
					dict1[money]=1
				else
					dict1[money]=dict1[money]+1
				end
			end
	end
	for i in keys(dict1) 
    	dict1[i]=dict1[i]/num
	end	
	probabiltyOfAtleast10=0
	for i in keys(dict1) 
		if i>=10
			probabiltyOfAtleast10=probabiltyOfAtleast10+dict1[i]
		end
	end
	return probabiltyOfAtleast10
end

# ╔═╡ 27ab4090-7416-11eb-2f9b-2f540100dab2
probabilityArrayWithoutBankrupt=[]

# ╔═╡ 27ab10a0-7416-11eb-33eb-f5673e460472
function simulation()
	empty!(probabilityArrayWithoutBankrupt)
	for prob in 1:100
		push!(probabilityArrayWithoutBankrupt,probabilityWithoutBankrupt(prob))
	end
    return probabilityArrayWithoutBankrupt
end

# ╔═╡ a4926b0a-7444-11eb-355f-9d4b76880357
emphiricalValuesWithoutBankrpt=simulation()

# ╔═╡ 792d4ed4-7416-11eb-0d9e-253bb14748c2
begin
	scatter(1:100,emphiricalValuesWithoutBankrpt)
end

# ╔═╡ 972ca6bc-7445-11eb-0d4f-abd109a761c0
function findBankruptcy(prob)
	bankruptycount=0
	num=100000
	for i in 1:num
		money=10
		for j in 1:20
			x=rand(1:100)
			if x<=(prob)
				money=money+1
			else 
				money=money-1
			end
			if money<=0
				bankruptycount=bankruptycount+1
				break
			end
		end
	end
	return bankruptycount/num
end

# ╔═╡ 9a7f8ad2-7445-11eb-2ee9-af0cd758c99a
function simulationBankruptcy()
	probabilityBankrupt=[]
	empty!(probabilityBankrupt)
	for prob in 1:100
		push!(probabilityBankrupt,findBankruptcy(prob))
	end
	return probabilityBankrupt
end

# ╔═╡ a8d47fca-7445-11eb-3e13-5ddc2484fda5
emphricalValues=simulationBankruptcy()

# ╔═╡ 5d9e0e08-741c-11eb-3ac6-adc4b300bc76
conditionalProbabilites=[emphiricalValuesWithoutBankrpt[i]/(1-emphricalValues[i]) for i in 1:100]

# ╔═╡ d1799812-741c-11eb-27c8-c92883c9252f
function theoriticalStockMarket(p)
	binomialDistribution=Distributions.Binomial(20,p/100)
	theoriticalValues=pdf(binomialDistribution)
	theoriticalProbability=0  
	for i in 11:length(theoriticalValues)
    	theoriticalProbability += theoriticalValues[i]
	end
	return theoriticalProbability
end

# ╔═╡ da7069a0-741c-11eb-21f1-33d4247d169d
function theoritical()
	theoriticalprobabilityArray=[]
	empty!(theoriticalprobabilityArray)
	for prob in 1:100
		push!(theoriticalprobabilityArray,theoriticalStockMarket(prob))
	end
	return theoriticalprobabilityArray
end

# ╔═╡ e1b7302c-741c-11eb-16d6-292fc2b95d32
theoreticalValues=theoritical()

# ╔═╡ 8fde0686-741c-11eb-21df-67ee8c8ac59a
begin
	scatter(1:100,conditionalProbabilites,labels="P(A ∩ B)")
	plot!(1:100,emphricalValues,labels="1-P(B)")
	scatter!(1:100,theoreticalValues,xlabel="0.01p",labels="P(A)")
end

# ╔═╡ Cell order:
# ╠═219e787a-7416-11eb-191f-3d7b41d51534
# ╠═27ab921e-7416-11eb-39a4-51d5fd893aaf
# ╠═27ab6fa0-7416-11eb-1498-39f64c0d4258
# ╠═27ab4090-7416-11eb-2f9b-2f540100dab2
# ╠═27ab10a0-7416-11eb-33eb-f5673e460472
# ╠═a4926b0a-7444-11eb-355f-9d4b76880357
# ╠═792d4ed4-7416-11eb-0d9e-253bb14748c2
# ╠═972ca6bc-7445-11eb-0d4f-abd109a761c0
# ╠═9a7f8ad2-7445-11eb-2ee9-af0cd758c99a
# ╠═a8d47fca-7445-11eb-3e13-5ddc2484fda5
# ╠═5d9e0e08-741c-11eb-3ac6-adc4b300bc76
# ╠═e8465616-741c-11eb-3617-9b254d8780d5
# ╠═d1799812-741c-11eb-27c8-c92883c9252f
# ╠═da7069a0-741c-11eb-21f1-33d4247d169d
# ╠═e1b7302c-741c-11eb-16d6-292fc2b95d32
# ╠═8fde0686-741c-11eb-21df-67ee8c8ac59a
