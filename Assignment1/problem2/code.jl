### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 4b6a59fc-6e0c-11eb-199b-ab84ef7f9949
using PlutoUI

# ╔═╡ 549fb5a8-6e0c-11eb-1c28-375d20125896
begin
	using Plots
	pyplot()
end

# ╔═╡ cdacee52-7355-11eb-0486-21d5263d7b87
using Distributions

# ╔═╡ 821d33ae-7355-11eb-103a-1161d9675509
md" Here the main idea is to take an array of 1-52 numbers and considering jacks are 1-4 and then randomly choosing a number from the card and then verifying it between 1-4"

# ╔═╡ 47221b08-6e0c-11eb-0387-9bbc7d13ffea
function simulateWithoutReplacement()
	num = 1000000
	cards=[]
	for j in 1:52
		push!(cards,j)
	end
	n = [0,0,0,0,0]
	for i in 1:num
		count=0
		cards1= copy(cards)
		for j in 1:5
			card=rand(cards1)
			deleteat!(cards1,findfirst(x->x==card,cards1))
			if card<=4
				count+=1
			end
		end
		n[count+1]+=1
	end
	return n=n/num
end

# ╔═╡ 3208716c-6f5e-11eb-0b77-89860f39aaf0
emphricalValuesWithoutReplacement=simulateWithoutReplacement()

# ╔═╡ f6f09212-6f5d-11eb-01f2-07a8e1159f07
begin
	plot(0:4,emphricalValuesWithoutReplacement,legend=false,xlabel="no of jacks",ylabel="Probability")
	scatter!(0:4,emphricalValuesWithoutReplacement,legend=false)
end

# ╔═╡ 71fffb36-7356-11eb-0621-71395e6d4d14
hyperdistribution=Distributions.Hypergeometric(4, 48, 5)

# ╔═╡ cd8ad060-7357-11eb-28a4-f18e5b3c99ef
theoriticalValuesWithOutReplacement=pdf(hyperdistribution)

# ╔═╡ 26bcff38-7357-11eb-3e0f-db770f751fce
begin
	plot(0:4,theoriticalValuesWithOutReplacement,legend=false)
	scatter!(0:4,theoriticalValuesWithOutReplacement,legend=false)
end

# ╔═╡ d5f96924-6e10-11eb-00e3-772797e9d771
function simulateWithReplacement()
	num = 10000000
	cards=1:52
	array = [0,0,0,0,0,0]
	for i in 1:num
		count=0
		for j in 1:5
			card=rand(cards)
			if card<=4
				count+=1
			end
		end
		array[count+1]+=1
	end
	array=array/num
end

# ╔═╡ a50cf49c-6e16-11eb-3533-91f44c3e8e4f
emphiricalValuesWithReplacement=simulateWithReplacement()

# ╔═╡ 0e87181a-6e14-11eb-3067-cbbebc8e5799
begin
	plot(0:5,emphiricalValuesWithReplacement,legend=false,xlabel="no of jacks",ylabel="Probability")
	scatter!(0:5,emphiricalValuesWithReplacement,legend=false)
end

# ╔═╡ eab3b4c6-7358-11eb-24dd-51d7c8f28bf4
binomialDistribution=Distributions.Binomial(5,4/52)

# ╔═╡ 51ba99dc-7359-11eb-1cd9-dda6a3a23c4b
theoriticalValuesWithReplacement=pdf(binomialDistribution)

# ╔═╡ 7a470c20-7359-11eb-0787-e50db74754f2
begin
	plot(0:5,theoriticalValuesWithReplacement,legend=false,xlabel="no of jacks",ylabel="Probability")
	scatter!(0:5,theoriticalValuesWithReplacement,legend=false)
end

# ╔═╡ Cell order:
# ╠═4b6a59fc-6e0c-11eb-199b-ab84ef7f9949
# ╠═549fb5a8-6e0c-11eb-1c28-375d20125896
# ╟─821d33ae-7355-11eb-103a-1161d9675509
# ╠═47221b08-6e0c-11eb-0387-9bbc7d13ffea
# ╠═3208716c-6f5e-11eb-0b77-89860f39aaf0
# ╠═f6f09212-6f5d-11eb-01f2-07a8e1159f07
# ╠═cdacee52-7355-11eb-0486-21d5263d7b87
# ╠═71fffb36-7356-11eb-0621-71395e6d4d14
# ╠═cd8ad060-7357-11eb-28a4-f18e5b3c99ef
# ╠═26bcff38-7357-11eb-3e0f-db770f751fce
# ╠═d5f96924-6e10-11eb-00e3-772797e9d771
# ╠═a50cf49c-6e16-11eb-3533-91f44c3e8e4f
# ╠═0e87181a-6e14-11eb-3067-cbbebc8e5799
# ╠═eab3b4c6-7358-11eb-24dd-51d7c8f28bf4
# ╠═51ba99dc-7359-11eb-1cd9-dda6a3a23c4b
# ╠═7a470c20-7359-11eb-0787-e50db74754f2
