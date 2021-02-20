### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ cc870964-7068-11eb-1592-c76c21ca2b7f
using PlutoUI

# ╔═╡ fcbe7f36-7068-11eb-2c7f-3165c9463fd5
begin
	using Plots
	pyplot()
end

# ╔═╡ 1dd135b4-706f-11eb-285f-f34490c66987
@bind p html"<input type=range min=1 max=100>"

# ╔═╡ aaa23fca-7070-11eb-2025-17dd9a57d353
p

# ╔═╡ 03efe128-706b-11eb-3886-bf3186be99af
begin
	num=100000
	dict=Dict()
	for i in 1:num
		money=10
		for j in 1:20
			
			x=rand(1:100)
			if x<=(p)
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
end

# ╔═╡ bb901a86-71bc-11eb-10fd-c36436ddd27a
begin
	probabiltyOfAtleast10=0
	for i in keys(dict) 
		if i>=10
			probabiltyOfAtleast10=probabiltyOfAtleast10+dict[i]
		end
	end
end

# ╔═╡ 18b02104-71bd-11eb-2d36-e95d22444dce
dict

# ╔═╡ e5ea15e8-71bc-11eb-1c32-03450f4807be
probabiltyOfAtleast10

# ╔═╡ b1707b18-7074-11eb-1f6c-656160f4838d
begin
	x=[]
	y=[]
	empty!(x)
	empty!(y)
	for (i,j) in sort(collect(dict), by=x->x[1])
		push!(x,i)
		push!(y,j)
	end
end

# ╔═╡ 1d1e4496-7073-11eb-13ef-258bf0c6908a
begin
	plot(x,y)
	scatter!(x,y)
	xlabel!("Money at the end of 20 tosses")
end

# ╔═╡ a42ab562-7133-11eb-32ab-07c3a619afe8


# ╔═╡ 75c4e6d6-71b8-11eb-0262-778299611952
begin
	bankruptycount=0
	for i in 1:num
		money=10
		for j in 1:20
			x=rand(1:100)
			if x<=(p)
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
	bankruptycount/num
end

# ╔═╡ 17361782-71ba-11eb-223e-83dbd66a8ad5
begin
	dict1=Dict()
	for i in 1:num
		money=10
		isbankrupted=false
		for j in 1:20
			
			x=rand(1:100)
			if x<=(p)
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
end

# ╔═╡ 2858be2e-71bd-11eb-2076-5518990d2896
dict1

# ╔═╡ 178f9cce-71bc-11eb-23e5-cdd1b96c5aff
begin
	total=0
	for i in keys(dict1)
		if i>=10
			total=total+dict1[i]
		end
	end
end

# ╔═╡ 6b653caa-71bc-11eb-295b-9b72ce3a733a
total

# ╔═╡ a13f191c-71bd-11eb-3e7f-7dc95a53b60a
total/(1-(bankruptycount/num))

# ╔═╡ Cell order:
# ╠═cc870964-7068-11eb-1592-c76c21ca2b7f
# ╠═fcbe7f36-7068-11eb-2c7f-3165c9463fd5
# ╠═1dd135b4-706f-11eb-285f-f34490c66987
# ╠═aaa23fca-7070-11eb-2025-17dd9a57d353
# ╠═03efe128-706b-11eb-3886-bf3186be99af
# ╠═bb901a86-71bc-11eb-10fd-c36436ddd27a
# ╠═18b02104-71bd-11eb-2d36-e95d22444dce
# ╠═2858be2e-71bd-11eb-2076-5518990d2896
# ╠═e5ea15e8-71bc-11eb-1c32-03450f4807be
# ╠═b1707b18-7074-11eb-1f6c-656160f4838d
# ╠═1d1e4496-7073-11eb-13ef-258bf0c6908a
# ╠═a42ab562-7133-11eb-32ab-07c3a619afe8
# ╠═75c4e6d6-71b8-11eb-0262-778299611952
# ╠═17361782-71ba-11eb-223e-83dbd66a8ad5
# ╠═178f9cce-71bc-11eb-23e5-cdd1b96c5aff
# ╠═6b653caa-71bc-11eb-295b-9b72ce3a733a
# ╠═a13f191c-71bd-11eb-3e7f-7dc95a53b60a
