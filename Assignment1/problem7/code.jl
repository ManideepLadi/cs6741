### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ a9236780-71bf-11eb-38c3-a12bd4edd2e4
using PlutoUI

# ╔═╡ bc2000dc-71bf-11eb-3df3-65ea4d51f300
begin
	using Plots
	pyplot()
end

# ╔═╡ aa733fd4-71c4-11eb-2874-53d9fc9bf809
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

# ╔═╡ e39888fa-71c4-11eb-087f-cfb2069fb23a
function simulation()
	probabilityBankrupt=[]
	empty!(probabilityBankrupt)
	for prob in 1:100
		push!(probabilityBankrupt,findBankruptcy(prob))
	end
	return probabilityBankrupt
end

# ╔═╡ e9cd36fc-7413-11eb-15bc-3f992e5aaeb0
emphricalValues=simulation()

# ╔═╡ 0d2aed20-71c5-11eb-2564-bf7946a7c4b0
begin
	plot(1:100,emphricalValues, legend=false,xlabel="0.01p",ylabel="ProbabilityOfBankruptcy")
	scatter!(1:100,emphricalValues,legend=false)
end

# ╔═╡ 3fcb3c4e-71c5-11eb-2d39-83d348ad0a1d
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

# ╔═╡ 89bbd05c-71c5-11eb-24c9-8d7baad6f192
probabilityArrayWithoutBankrupt=[]

# ╔═╡ 9d8a5798-71c5-11eb-024c-2f2608e34242
begin
	empty!(probabilityArrayWithoutBankrupt)
	for prob in 1:100
		push!(probabilityArrayWithoutBankrupt,probabilityWithoutBankrupt(prob))
	end
end

# ╔═╡ abc4733e-71c5-11eb-2a42-9bf1c4e15c84
begin
	plot(1:100,probabilityArray)
	plot!(1:100,probabilityBankrupt)
end

# ╔═╡ Cell order:
# ╠═a9236780-71bf-11eb-38c3-a12bd4edd2e4
# ╠═bc2000dc-71bf-11eb-3df3-65ea4d51f300
# ╠═aa733fd4-71c4-11eb-2874-53d9fc9bf809
# ╠═e39888fa-71c4-11eb-087f-cfb2069fb23a
# ╠═e9cd36fc-7413-11eb-15bc-3f992e5aaeb0
# ╠═0d2aed20-71c5-11eb-2564-bf7946a7c4b0
# ╠═3fcb3c4e-71c5-11eb-2d39-83d348ad0a1d
# ╠═89bbd05c-71c5-11eb-24c9-8d7baad6f192
# ╠═9d8a5798-71c5-11eb-024c-2f2608e34242
# ╠═abc4733e-71c5-11eb-2a42-9bf1c4e15c84
