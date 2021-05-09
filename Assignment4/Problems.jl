### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ f47d1542-a97f-11eb-0db0-9f2a88df9a8c
begin
	using Plots
	plotly()
end

# ╔═╡ 492d5f34-a980-11eb-19d0-93ee6be63f3c
begin
    using PlutoUI
    using StatsPlots
    using RDatasets
    using StatsBase
    using Distributions
    using LaTeXStrings
	using Statistics
end

# ╔═╡ f58a8ec2-a983-11eb-3ef8-8fc310d67ad2
using QuadGK

# ╔═╡ 5708ec1a-a980-11eb-3c2c-edb2c1615b0f
md"Q1. (3 points) You are a statistical (and boring) version of the Two-Face. You throw a fair coin 50 times. If it comes out Heads in at least 30 out of these 50 tosses, you decide to go ahead with a decision. 
Compute the probability of you going ahead with the decision. Do this in three different ways: 
Monte Carlo simulation of using an appropriately chosen large number of trials
Computation using the binomial distribution
Approximation using the central limit theorem"

# ╔═╡ b2c17736-a980-11eb-1168-b3cb3161942a
md"Monte Carlo Simulation"

# ╔═╡ bfc8967e-a980-11eb-3846-7f7567d5ef99
begin
	coin =[0,1]
	count=0
	for j in 1:10000
		sum=0
		for i in 1:50
			x=rand(coin)
			sum=sum+x
		end
		if sum>=30
			count=count+1
		end
	end
	probability=count/10000
	probability
end

# ╔═╡ 3687c4c8-a982-11eb-0776-11b4cc524756
md"Binomial Distribution"

# ╔═╡ 46569d34-a982-11eb-34d1-23f56d560ea6
D=Binomial(50,0.5)

# ╔═╡ 8a07b388-a982-11eb-1c92-ab891bb08f0f
plot(pdf(D))

# ╔═╡ 00a2ac36-a989-11eb-3af2-910fa595c59b
md"Approximation using Central Limit therom"

# ╔═╡ 4b74db2e-a983-11eb-30c4-29003a84d7d8
D2=Normal(25,sqrt(12.5))

# ╔═╡ 22a77a3e-ae3c-11eb-3692-73e2b5ecbf95
plot(Normal(25,sqrt(12.5)))

# ╔═╡ 78e7451c-a984-11eb-0e8b-6d9b88ecdf0e
begin
	Dist=Normal(25,sqrt(12.5))
	f2(x)=pdf(Dist,x)
	q2,error2=quadgk(f2, 29.5, 50)
	q2
end

# ╔═╡ 9617ff28-ae34-11eb-2722-418e9c243818
md"The complementary cumulative function evaluated at x, i.e. 1 - cdf(d, x)"

# ╔═╡ f5092b9e-ae32-11eb-0d2b-6b8de04a6434
ccdf(Normal(25,sqrt(12.5)), 29.5)

# ╔═╡ 50ce0010-ae35-11eb-3b21-75288451b217
md"Q2. (2 points) Since you are Two-Face, you would like to tweak the two faces of the coin. You want to minimally increase the probability of a toss coming up as Heads such that the above experiment has at least a 50% chance of going ahead. 

Solve this problem using CLT.

Verify that you have solved the problem with both Monte Carlo simulations and using the analytical Binomial distribution. "

# ╔═╡ 69c43b7a-ae35-11eb-0744-53fb02079446
md"Monte Carlo simulation"

# ╔═╡ bf2e31a0-ae36-11eb-1b50-a3ccaac6f0be
begin
	ans=0
	for p in 1:100
		UnfairCoin = [1 for i in 1:p]
		for j in p+1:100
			push!(UnfairCoin,0)
		end
		count=0
		for j in 1:10000
			sum=0
			for i in 1:50
				x=rand(UnfairCoin)
				sum=sum+x
			end
			if sum>=30
				count=count+1
			end
		end
		requiredProbability=count/10000
	    if requiredProbability>=0.5
			ans=p
			break
		end
	end	
	ans/100
end

# ╔═╡ da140c1e-ae3c-11eb-05fd-1b09a3b2b8d2
md"Verification"

# ╔═╡ 76e580f4-ae35-11eb-3da7-091628698081
begin
	UnfairCoin = [1 for i in 1:60]
	for j in 60+1:100
		push!(UnfairCoin,0)
	end
	count2=0
	for j in 1:10000
		sum=0
		for i in 1:50
			x=rand(UnfairCoin)
			sum=sum+x
		end
		if sum>=30
			count2=count2+1
		end
	end
	probability2=count2/10000
	probability2
end

# ╔═╡ eb507678-ae3b-11eb-067e-01a525cfd349
md"Using Central Limit theorem"

# ╔═╡ 00d372e6-ae3c-11eb-2f55-53a04f6de243
begin
	plot(Normal(30,sqrt(12)))
	plot!(pdf(Binomial(50,0.6)))
end

# ╔═╡ 5f04ce36-afcd-11eb-1fbd-33a0c4c5adef
md"Q3. (2 points) You are on the world’s first civilian migration to Mars. You have to of course depend on space suits for survival. Each space suit can last for an average of 100 days but with a standard deviation of 30 days. Estimate the minimum number of space suits you have to pack in your luggage to last 3000 days with a probability of at least 95%. 

Setup the computation using Central Limit Theorem and then write the Julia code to explore the right number of space suits"

# ╔═╡ 6f2d35c8-afcd-11eb-31ec-cfedfaa1668f
begin
	suits = 1
	for i in 1:100
		if (-49.35*sqrt(i))+(100*i) > 3000
			suits= i
			break
		end
	end
	suits
end

# ╔═╡ 7517a292-b09b-11eb-3375-e77c518a9340
1-cdf(Normal(3300,30(sqrt(33))),3001)

# ╔═╡ dfafc3b6-afd1-11eb-2c26-91290b5a2904
md"Q4. (2 points) One way to compare distributions is to ensure that the first few moments of two distributions are reasonably close. For each of the following distributions, compute the smallest sample size at which the approximation made to the normal distribution derived from CLT matches the first four moments within 5% (wrt the Normal distribution):
Uniform distribution between 0 and 1
Binomial distribution with p = 0.01
Binomial distribution with p = 0.5
Chi-square distribution with 3 degrees of freedom
"

# ╔═╡ 942f95b0-b094-11eb-1aa6-373e986d6587
begin
	NForUniform=0
	Uniform_currentdist=[]
	for n in 1:50
		dist=[]
		centereddist=[]
		for i in 1:100000
			x=0
			for j in 1:n
				x=x+rand(Uniform(0,1))
			end
			push!(dist,x)
		end
		firstm=mean(dist)
		secondm=std(dist)
		centereddist=[(j-firstm)/secondm for j in dist]
		skewnessdist=[j^3 for j in centereddist]
		thirdm = mean(skewnessdist)
		kurtosisdist=[j^4 for j in centereddist]
		fourthm=mean(kurtosisdist)
		if abs(thirdm)<0.1  && abs(fourthm-3)<0.1
			NForUniform=n
			Uniform_currentdist=centereddist
			break
		end
	end
	NForUniform
end
		

# ╔═╡ 6dfc7ef2-b095-11eb-16f2-93c7458bfa1d
begin
	density(Uniform_currentdist,label="Emphircal Distribution of $NForUniform U(0,1)")
	plot!(Normal(0,1),label="Standard Normal Distribution")
end

# ╔═╡ 6c7d5d46-afdf-11eb-3f69-09c3fe753156
begin
	NForBinomial=0
	Binomial_currentdist=[]
	for n in 70:100
		dist=[]
		centereddist=[]
		for i in 1:100000
			x=0
			for j in 1:n
				x=x+rand(Binomial(100,0.01))
			end
			push!(dist,x)
		end
		firstm=mean(dist)
		secondm=std(dist)
		centereddist=[(j-firstm)/secondm for j in dist]
		skewnessdist=[j^3 for j in centereddist]
		thirdm = mean(skewnessdist)
		kurtosisdist=[j^4 for j in centereddist]
		fourthm=mean(kurtosisdist)
		if abs(thirdm)<0.1  && abs(fourthm-3)<0.1
			NForBinomial=n
			Binomial_currentdist=centereddist
			break
		end
	end
	NForBinomial
end
		

# ╔═╡ e73c035a-afe6-11eb-399b-d1f20c744333
begin
	density(Binomial_currentdist,label="Emphircal Distribution of $NForBinomial binomial with p=0.01")
	plot!(Normal(0,1),label="Standard Normal Distribution")
end

# ╔═╡ a22b03c0-afe5-11eb-0196-171a61b15d4f
begin
	NForBinomial2=0
	Binomial2_currentdist=[]
	for n in 1:100
		dist=[]
		centereddist=[]
		for i in 1:10000
			x=0
			for j in 1:n
				x=x+rand(Binomial(100,0.5))
			end
			push!(dist,x)
		end
		firstm=mean(dist)
		secondm=std(dist)
		centereddist=[(j-firstm)/secondm for j in dist]
		skewnessdist=[j^3 for j in centereddist]
		thirdm = mean(skewnessdist)
		kurtosisdist=[j^4 for j in centereddist]
		fourthm=mean(kurtosisdist)
		if abs(thirdm)<0.1  && abs(fourthm-3)<0.1
			NForBinomial2=n
			Binomial2_currentdist=centereddist
			break
		end
	end
	NForBinomial2
end

# ╔═╡ bf698e5a-b096-11eb-01ce-7b1a0efd38cf
begin
	density(Binomial2_currentdist,label="Emp Distribution of $NForBinomial2 binomial with p=0.5")
	plot!(Normal(0,1),label="Standard Normal Distribution")
end

# ╔═╡ 0d7a4f4e-b097-11eb-1bfa-c30215d06d92
begin
	NForChisquare3=0
	chisquare3_currentdist=[]
	for n in 100:150
		dist=[]
		centereddist=[]
		for i in 1:10000
			x=0
			for j in 1:n
				x=x+rand(Chisq(3))
			end
			push!(dist,x)
		end
		firstm=mean(dist)
		secondm=std(dist)
		centereddist=[(j-firstm)/secondm for j in dist]
		skewnessdist=[j^3 for j in centereddist]
		thirdm = mean(skewnessdist)
		kurtosisdist=[j^4 for j in centereddist]
		fourthm=mean(kurtosisdist)
		if abs(thirdm)<0.1  && abs(fourthm-3)<0.1
			NForChisquare3=n
			chisquare3_currentdist=centereddist
			break
		end
	end
	NForChisquare3
end

# ╔═╡ 8d773824-b097-11eb-1b80-dd0bac997f3e
begin
	density(chisquare3_currentdist,label="Emphircal Distribution of $NForChisquare3 chisquare(3)")
	plot!(Normal(0,1),label="Standard Normal Distribution")
end

# ╔═╡ Cell order:
# ╠═f47d1542-a97f-11eb-0db0-9f2a88df9a8c
# ╠═492d5f34-a980-11eb-19d0-93ee6be63f3c
# ╟─5708ec1a-a980-11eb-3c2c-edb2c1615b0f
# ╟─b2c17736-a980-11eb-1168-b3cb3161942a
# ╠═bfc8967e-a980-11eb-3846-7f7567d5ef99
# ╟─3687c4c8-a982-11eb-0776-11b4cc524756
# ╠═46569d34-a982-11eb-34d1-23f56d560ea6
# ╠═8a07b388-a982-11eb-1c92-ab891bb08f0f
# ╠═f58a8ec2-a983-11eb-3ef8-8fc310d67ad2
# ╟─00a2ac36-a989-11eb-3af2-910fa595c59b
# ╠═4b74db2e-a983-11eb-30c4-29003a84d7d8
# ╠═22a77a3e-ae3c-11eb-3692-73e2b5ecbf95
# ╠═78e7451c-a984-11eb-0e8b-6d9b88ecdf0e
# ╟─9617ff28-ae34-11eb-2722-418e9c243818
# ╠═f5092b9e-ae32-11eb-0d2b-6b8de04a6434
# ╟─50ce0010-ae35-11eb-3b21-75288451b217
# ╟─69c43b7a-ae35-11eb-0744-53fb02079446
# ╠═bf2e31a0-ae36-11eb-1b50-a3ccaac6f0be
# ╟─da140c1e-ae3c-11eb-05fd-1b09a3b2b8d2
# ╠═76e580f4-ae35-11eb-3da7-091628698081
# ╟─eb507678-ae3b-11eb-067e-01a525cfd349
# ╠═00d372e6-ae3c-11eb-2f55-53a04f6de243
# ╟─5f04ce36-afcd-11eb-1fbd-33a0c4c5adef
# ╠═6f2d35c8-afcd-11eb-31ec-cfedfaa1668f
# ╠═7517a292-b09b-11eb-3375-e77c518a9340
# ╟─dfafc3b6-afd1-11eb-2c26-91290b5a2904
# ╠═942f95b0-b094-11eb-1aa6-373e986d6587
# ╠═6dfc7ef2-b095-11eb-16f2-93c7458bfa1d
# ╠═6c7d5d46-afdf-11eb-3f69-09c3fe753156
# ╠═e73c035a-afe6-11eb-399b-d1f20c744333
# ╠═a22b03c0-afe5-11eb-0196-171a61b15d4f
# ╠═bf698e5a-b096-11eb-01ce-7b1a0efd38cf
# ╠═0d7a4f4e-b097-11eb-1bfa-c30215d06d92
# ╠═8d773824-b097-11eb-1b80-dd0bac997f3e
