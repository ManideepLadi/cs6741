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
values=simulateWithReplacement()

# ╔═╡ 0e87181a-6e14-11eb-3067-cbbebc8e5799
begin
	plot(0:5,values,legend=false)
	scatter!(0:5,values,legend=false)
end

# ╔═╡ 47221b08-6e0c-11eb-0387-9bbc7d13ffea
begin
	num = 10000000
	cards=1:52
	array = [0,0,0,0,0,0]
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
		array[count+1]+=1
	end
	array=array/num
end

# ╔═╡ Cell order:
# ╠═4b6a59fc-6e0c-11eb-199b-ab84ef7f9949
# ╠═549fb5a8-6e0c-11eb-1c28-375d20125896
# ╠═d5f96924-6e10-11eb-00e3-772797e9d771
# ╠═a50cf49c-6e16-11eb-3533-91f44c3e8e4f
# ╠═0e87181a-6e14-11eb-3067-cbbebc8e5799
# ╠═47221b08-6e0c-11eb-0387-9bbc7d13ffea
