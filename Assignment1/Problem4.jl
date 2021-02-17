### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 95894632-6f98-11eb-39eb-a91868aa4af1
using PlutoUI

# ╔═╡ b580df0e-6f98-11eb-11f0-055fcf150c6f
begin
	using Plots
	pyplot()
end

# ╔═╡ e6086dca-6f9a-11eb-2e06-e92521cf758e
using Random

# ╔═╡ ad18d204-6f9d-11eb-0c94-7700c7268c0c
function GenerateRandomPassword(n)
	password=randstring("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz~`!@#\$%^&*()_-+=", n)
	return String(shuffle!(collect(password)))
end

# ╔═╡ 96c81a54-6f9e-11eb-3d3f-e7c94a6a33e9
function SimulateHacker()
	OriginalPassword=GenerateRandomPassword(8)
	databaseStorageCount=0
	for i in 1:1000000
		count=0
		hackerPassword=GenerateRandomPassword(8)
		for j in 1:8
			if OriginalPassword[j]==hackerPassword[j]
				count=count+1
			end
		end
		if count>=2
			databaseStorageCount=databaseStorageCount+1
		end
	end
	return databaseStorageCount
end

# ╔═╡ d7504a14-6f9f-11eb-2b7b-c1c7c6cbab2c
emphricalProbability=SimulateHacker()/1000000

# ╔═╡ 93ed1386-7136-11eb-134b-e5640a65ee07
md"Probability of a password gets stored in a database if at least two characters in the entered password are exactly the same (position and value) as the actual password is same as 1 minus probablity of no character match along with probability with 1 character match"

# ╔═╡ d00512ba-7136-11eb-0568-d19dc2e7ae8a
md"Total possible 8 characters passwords with alphabets (both lower and upper case), numericals (0 to 9) and special characters (16 options ~ ! @ # $ % ^ & * ( ) _  + = - `) is (78)^8"

# ╔═╡ 88afe1c8-7137-11eb-30bc-f5e5cb3672e6
md" Possibe cases for no character match is (77)^8"

# ╔═╡ b26b7c16-7137-11eb-3409-f5fde2969e03
md"Possible cases of 1 character match is 8*(77)^7"

# ╔═╡ 7ed26bcc-7136-11eb-1a7d-f3456d537809
PossibleOutcomes= (77^8+8*(77)^7)

# ╔═╡ 04c5b74c-7138-11eb-2719-bba464c0171e
TotalOutcomes = 78^8

# ╔═╡ 12ec3936-7138-11eb-1fff-4d4988219bdf
ProbablityOf0or1Match=PossibleOutcomes/TotalOutcomes

# ╔═╡ 3563bd18-7138-11eb-18dc-4df3b3240b94
theoriticalRequiredProbablity=1-ProbablityOf0or1Match

# ╔═╡ 5d2a8e62-7138-11eb-23a8-11d71877d95b
md" The emphricalProbability is $emphricalProbability and theoritical probablity is $theoriticalRequiredProbablity"

# ╔═╡ Cell order:
# ╠═95894632-6f98-11eb-39eb-a91868aa4af1
# ╠═b580df0e-6f98-11eb-11f0-055fcf150c6f
# ╠═e6086dca-6f9a-11eb-2e06-e92521cf758e
# ╠═ad18d204-6f9d-11eb-0c94-7700c7268c0c
# ╠═96c81a54-6f9e-11eb-3d3f-e7c94a6a33e9
# ╠═d7504a14-6f9f-11eb-2b7b-c1c7c6cbab2c
# ╟─93ed1386-7136-11eb-134b-e5640a65ee07
# ╟─d00512ba-7136-11eb-0568-d19dc2e7ae8a
# ╟─88afe1c8-7137-11eb-30bc-f5e5cb3672e6
# ╟─b26b7c16-7137-11eb-3409-f5fde2969e03
# ╠═7ed26bcc-7136-11eb-1a7d-f3456d537809
# ╠═04c5b74c-7138-11eb-2719-bba464c0171e
# ╠═12ec3936-7138-11eb-1fff-4d4988219bdf
# ╠═3563bd18-7138-11eb-18dc-4df3b3240b94
# ╠═5d2a8e62-7138-11eb-23a8-11d71877d95b
