### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ c04753c2-73a4-11eb-252b-79d76d2f389d
using Random

# ╔═╡ 908153f4-73a4-11eb-3d4f-efa77bd0952a
function GenerateRandomPassword(n)
	password=randstring("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz~`!@#\$%^&*()_-+=", n)
	return String(shuffle!(collect(password)))
end

# ╔═╡ 9bb88460-73a4-11eb-1f8d-893fb67bb0bf
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
		if count>=3
			databaseStorageCount=databaseStorageCount+1
		end
	end
	return databaseStorageCount
end

# ╔═╡ b6e5ac52-73a4-11eb-2af6-c1198eab2dca
emphricalStorageValue=SimulateHacker()

# ╔═╡ 1f1016f6-73a6-11eb-3034-ed64838a18f7
md"Probability of a password gets stored in a database if at least two characters in the entered password are exactly the same (position and value) as the actual password is same as 1 minus probablity of no character match along with probability with 1 character match and 2 character match"

# ╔═╡ 215a8014-73a6-11eb-07b0-b53cd9fa2a11
md" Possibe cases for no character match is (77)^8"

# ╔═╡ 33f74bbe-73a6-11eb-2c3d-03905275aa13
md"Possible cases of 1 character match is 8*(77)^7"

# ╔═╡ a2e4bbf4-73a6-11eb-2afd-6d0540378985
md"Possible cases of 1 character match is 8c2*(77)^6"

# ╔═╡ 75539860-73a6-11eb-2980-21192f628a7c
PossibleOutcomes= (77^8+8*(77)^7+28*(77)^6)

# ╔═╡ 9eb97e72-73a6-11eb-0a7f-df65192241d4
TotalOutcomes = 78^8

# ╔═╡ b5970a92-73a6-11eb-0630-e351ec4f8630
ProbablityOf0or1or2Match=PossibleOutcomes/TotalOutcomes

# ╔═╡ bc654e60-73a6-11eb-0271-a1b32d153bcc
theoriticalRequiredProbablity=1-ProbablityOf0or1or2Match

# ╔═╡ cc19ae82-73a6-11eb-2ab8-0b6636b22d56
noOfpasswordstored= theoriticalRequiredProbablity*1000000

# ╔═╡ Cell order:
# ╠═c04753c2-73a4-11eb-252b-79d76d2f389d
# ╠═908153f4-73a4-11eb-3d4f-efa77bd0952a
# ╠═9bb88460-73a4-11eb-1f8d-893fb67bb0bf
# ╠═b6e5ac52-73a4-11eb-2af6-c1198eab2dca
# ╟─1f1016f6-73a6-11eb-3034-ed64838a18f7
# ╟─215a8014-73a6-11eb-07b0-b53cd9fa2a11
# ╟─33f74bbe-73a6-11eb-2c3d-03905275aa13
# ╟─a2e4bbf4-73a6-11eb-2afd-6d0540378985
# ╠═75539860-73a6-11eb-2980-21192f628a7c
# ╠═9eb97e72-73a6-11eb-0a7f-df65192241d4
# ╠═b5970a92-73a6-11eb-0630-e351ec4f8630
# ╠═bc654e60-73a6-11eb-0271-a1b32d153bcc
# ╠═cc19ae82-73a6-11eb-2ab8-0b6636b22d56
