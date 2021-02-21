### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ c1f17c14-6d5c-11eb-18ed-1b5e62881cdd
using PlutoUI

# ╔═╡ ca35c1d2-6d5c-11eb-2a61-ef089b903140
begin
	using Plots
	pyplot()
end

# ╔═╡ 41b3d382-744e-11eb-292f-e3b87dee4ea5
using Random

# ╔═╡ 9eb193c6-744e-11eb-078a-6bfbab9cc59e
randomIntegers=[]

# ╔═╡ cc15dfee-7448-11eb-2b4b-bde211742465
function GenerateRandomIntegers()
	randomIntegers=[]
	empty!(randomIntegers)
	for prob in 1:100000
		push!(randomIntegers,rand(-1000:1000))
	end
	return randomIntegers
end

# ╔═╡ df249b94-744e-11eb-3839-2dcaa598e5b6
function simulateLawofLargeNumbers()
	randomIntegers=GenerateRandomIntegers()
	mean=sum(randomIntegers) / length(randomIntegers)
	return mean
end

# ╔═╡ ef85de2c-6d5c-11eb-15c8-178592486546
mean=simulateLawofLargeNumbers()

# ╔═╡ 0a90f5e4-6d5d-11eb-0953-9f6820643ef8
begin
	histogram(GenerateRandomIntegers(), bins = -100:100, normalize=true, legend=false)
end

# ╔═╡ Cell order:
# ╠═c1f17c14-6d5c-11eb-18ed-1b5e62881cdd
# ╠═ca35c1d2-6d5c-11eb-2a61-ef089b903140
# ╠═41b3d382-744e-11eb-292f-e3b87dee4ea5
# ╠═9eb193c6-744e-11eb-078a-6bfbab9cc59e
# ╠═cc15dfee-7448-11eb-2b4b-bde211742465
# ╠═df249b94-744e-11eb-3839-2dcaa598e5b6
# ╠═ef85de2c-6d5c-11eb-15c8-178592486546
# ╠═0a90f5e4-6d5d-11eb-0953-9f6820643ef8
