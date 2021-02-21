### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ efb5914a-735f-11eb-2012-335ea65f2c0b
using PlutoUI

# ╔═╡ fc10e15e-735f-11eb-114f-3f136b7c94d7
begin
	using Plots
	pyplot()
end

# ╔═╡ 179e7960-7360-11eb-3ed8-5b8d83b4aeee
using Distributions

# ╔═╡ 2a6075bc-7360-11eb-028e-1d2a464c0f86
hyperdistribution=Distributions.Hypergeometric(4, 48, 5)

# ╔═╡ 34504980-7360-11eb-3c15-91dcdd61d9bf
theoriticalValuesWithOutReplacement=pdf(hyperdistribution)

# ╔═╡ 279946c8-7361-11eb-22fa-2d57809aa4c4
emphricalValuesWithoutReplacement=[0.658951,0.299119,0.040143,0.001767,2.0e-5,]

# ╔═╡ 3e2276d6-7360-11eb-0ba9-31bd3819b4f5
begin
	p1=plot(0:4,emphricalValuesWithoutReplacement,legend=false,xlabel="No of Jacks",ylabel="Experimental Probability")
	p1=scatter!(0:4,emphricalValuesWithoutReplacement,legend=false)
	p2=plot(0:4,theoriticalValuesWithOutReplacement,legend=false,xlabel="No of Jacks",ylabel="Theoritical Probability")
	p2=scatter!(0:4,theoriticalValuesWithOutReplacement,legend=false)
	plot(p1,p2,layout=2)
end

# ╔═╡ ed5ab0ee-7362-11eb-1c95-a3ab96f2ae9a
emphiricalValuesWithReplacement=[0.670009,0.279567,0.0463918,0.0038659,0.0001645,2.3e-6]

# ╔═╡ 52b336fa-7363-11eb-3b1b-b7ccda3a6f8f
binomialDistribution=Distributions.Binomial(5,4/52)

# ╔═╡ 55d8cc30-7363-11eb-2511-5de7b119a8b0
theoriticalValuesWithReplacement=pdf(binomialDistribution)

# ╔═╡ 61dce2ca-7363-11eb-172b-99a59b9b31f2
begin
	p3=plot(0:5,emphiricalValuesWithReplacement,legend=false,xlabel="No of Jacks",ylabel="Experimental Probability")
	p3=scatter!(0:5,emphiricalValuesWithReplacement,legend=false)
	p4=plot(0:5,theoriticalValuesWithReplacement,legend=false,xlabel="No of Jacks",ylabel="Theoritical Probability")
	p4=scatter!(0:5,theoriticalValuesWithReplacement,legend=false)
	plot(p3,p4,layout=2)
end

# ╔═╡ Cell order:
# ╠═efb5914a-735f-11eb-2012-335ea65f2c0b
# ╠═fc10e15e-735f-11eb-114f-3f136b7c94d7
# ╠═179e7960-7360-11eb-3ed8-5b8d83b4aeee
# ╠═2a6075bc-7360-11eb-028e-1d2a464c0f86
# ╠═34504980-7360-11eb-3c15-91dcdd61d9bf
# ╠═279946c8-7361-11eb-22fa-2d57809aa4c4
# ╠═3e2276d6-7360-11eb-0ba9-31bd3819b4f5
# ╠═ed5ab0ee-7362-11eb-1c95-a3ab96f2ae9a
# ╠═52b336fa-7363-11eb-3b1b-b7ccda3a6f8f
# ╠═55d8cc30-7363-11eb-2511-5de7b119a8b0
# ╠═61dce2ca-7363-11eb-172b-99a59b9b31f2
