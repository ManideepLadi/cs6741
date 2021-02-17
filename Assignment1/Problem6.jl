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


# ╔═╡ cce522d2-706e-11eb-2cc8-39b6c3043baa
begin
	sum=0
	for i in keys(dict) 
		if i<=0
			sum=sum+dict[i]
		end
	end
end

# ╔═╡ 8642ce4a-7133-11eb-1b2a-df0f21403c20
sum

# ╔═╡ Cell order:
# ╠═cc870964-7068-11eb-1592-c76c21ca2b7f
# ╠═fcbe7f36-7068-11eb-2c7f-3165c9463fd5
# ╠═1dd135b4-706f-11eb-285f-f34490c66987
# ╠═aaa23fca-7070-11eb-2025-17dd9a57d353
# ╠═03efe128-706b-11eb-3886-bf3186be99af
# ╠═b1707b18-7074-11eb-1f6c-656160f4838d
# ╠═1d1e4496-7073-11eb-13ef-258bf0c6908a
# ╠═a42ab562-7133-11eb-32ab-07c3a619afe8
# ╠═cce522d2-706e-11eb-2cc8-39b6c3043baa
# ╠═8642ce4a-7133-11eb-1b2a-df0f21403c20
