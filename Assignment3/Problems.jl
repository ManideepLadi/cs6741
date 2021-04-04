### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 7e810192-92b0-11eb-33fb-0dade801e855
begin
	using Plots
	plotly()
end

# ╔═╡ 39021be0-9512-11eb-05ac-8364231a3682
using QuadGK

# ╔═╡ 387a18ca-90a6-11eb-33f9-c524bd629dde
using DataFrames

# ╔═╡ a98761a4-90af-11eb-0be1-051a211749fb
begin
    using PlutoUI
    using StatsPlots
    using RDatasets
    using StatsBase
    using Distributions
    using LaTeXStrings
end

# ╔═╡ 86620fd4-90a9-11eb-0de3-1dcbdf80939b
using Dates

# ╔═╡ 55e7ac38-944d-11eb-3b2d-cdeea518f1d2
md" (1.5 points) How do we compare two distributions, i.e., how do we say that one distribution is very similar to another distribution? We need a distance measure. There are many statistical distances. For this question, you will implement the Kullback-Leibler divergence, which is formally defined between distributions P and Q of two random distributions as:

Implement a Julia function which computes the KL divergence for two given distributions. 

Now call this function for Q set as N(0, 1) and P as Student’s T distribution separately with v = 1, 2, 3, 4, 5 degrees of freedom. "

# ╔═╡ 6b2d35e0-944d-11eb-20d6-33ec690694d0
klDivergence(P,Q) = sum(pdf(P,x)*(log(pdf(P,x)/pdf(Q,x)))*0.1 for x =-10:0.1:10)

# ╔═╡ 905089b0-9512-11eb-30d4-19dc636da944
P=Normal(0,1)

# ╔═╡ c480c0f6-9512-11eb-0cae-a578138f7c65
Q = TDist(5)

# ╔═╡ 269440a2-9512-11eb-29bd-8b1018e2a53c
begin
	f1(x)=pdf(P,x)*(log(pdf(P,x)/pdf(Q,x)))
	q,error = quadgk(f1, -10, 10)
	q
end


# ╔═╡ ce34494e-9512-11eb-2ea1-451ad03b4b5b
md"Q2. (1.5 points) We have seen that as we add independent random variables, the resultant pdf of the sum of random variables tends towards a normal distribution. We can quantify this tendency now that we know about the KL divergence as a measure.

Consider U as the uniform distribution in the range [0, 1]. Write a function that computes the pdf of the random variable obtained by summing n independent random variates drawn from U. (Hint: recall that when we sum up independent variables, the pdfs get convolved). 

For n varying from 2 to 10, plot the KL divergence with P given by the output of your function with the corresponding n and Q as the normal distribution with mean and standard deviation matching that of P."

# ╔═╡ 14c7609c-9513-11eb-1ec5-89976e8c7724
begin
	n=10
	conv_arr=[]
	conv(x) = sum(pdf(D_1,x-k)*pdf(D_2,k)*(0.1) for k=-10:0.1:10)
	D_1 = Uniform(0, 1)
	D_2 = Uniform(0, 1)
	push!(conv_arr,[conv.(-10:.1:10)])
	for i in 1:n-2
		conv2(x)=sum(pdf(D_1,x-k)*conv_arr[i][1][trunc(Int, k*10)+101]*(0.01) for k=-10:0.01:10)
		push!(conv_arr,[conv2.(-10:.1:10)])
	end
end


# ╔═╡ 2fe219a8-9513-11eb-06bd-63ceaf186dec
conv_arr

# ╔═╡ 5a034c48-9513-11eb-0d2b-617bd05588d7
plot(conv_arr, title="covolution distribution for x number of covolutions ")

# ╔═╡ f20a0c94-9519-11eb-1d9b-fdd68485afac
dist=Normal(mean(conv_arr[9][1]),var(conv_arr[9][1]))

# ╔═╡ ba5d4ada-9568-11eb-2e38-35b761903449
distArray=[pdf(dist,x) for x=-10:0.1:10]

# ╔═╡ 2ace66c8-9569-11eb-0ebe-c74d62353bc5
length(distArray)

# ╔═╡ c07d3ea4-9516-11eb-19b5-970c4feafa14
begin
	kl=0
	for x =1:201
		if conv_arr[9][1][x]!=0 && distArray[x]!=0
			kl=kl+conv_arr[9][1][x]*(log(conv_arr[9][1][x]/distArray[x]))
		end
	end
end

# ╔═╡ 39fdc0e6-9567-11eb-3e96-d7843d2f60fd
kl

# ╔═╡ e70cc794-9569-11eb-1b3f-651842ac9cd4
begin
	k=zeros(9)
	for i=1:9
		dis=Normal(mean(conv_arr[i][1]),var(conv_arr[i][1]))	
		disArray=[pdf(dis,k) for k=-10:0.1:10]
		for x =1:201
			if conv_arr[i][1][x]!=0 && distArray[x]!=0
				k[i]=k[i]+conv_arr[i][1][x]*(log(conv_arr[i][1][x]/disArray[x]))
			end
		end
	end
end

# ╔═╡ 5494f62e-956a-11eb-120f-2d1fc0b59f6b
k

# ╔═╡ b6d1c96c-9519-11eb-3f7f-6d3cd178019a
begin
	plot(k,xlabel="number of uniform pdfs convoluted",ylabel="kldivergence Values")
	scatter!(k)
end

# ╔═╡ 0ba271c4-92b0-11eb-0793-f567d8f4ab7c
md"Q3. (1 points) We saw that Pearson defined his coefficients of skewness based on the relative order of mean, median, and mode. But these are merely rules of thumb. 

Create a synthetic dataset (you are free to do this however you like) of at least 1,000 points such that the distribution of the data is distinctly right skewed, but mean is smaller than the median.
"

# ╔═╡ cf64da6a-92c2-11eb-32c9-f37f942d7abf
begin
	samples=[997 for i in 1:300]
	for j in 1:200
		push!(samples,998)
	end
	for j in 1:600
		push!(samples,1000)
	end
	for j in 1:490
		push!(samples,1001)
	end
	for j in 1:100
		push!(samples,1002)
	end
	for j in 1:20
		push!(samples,(1003))
	end
	for j in 1:10
		push!(samples,1004)
	end
	for j in 1:9
		push!(samples,(1005))
	end
	for j in 1:8
		push!(samples,1006)
	end
	for j in 1:7
		push!(samples,1007)
	end
	for j in 1:6
		push!(samples,1008)
	end
	x=rand(Normal(0,1),length(samples))
	samples2=samples+x
end

# ╔═╡ 1426446c-92ba-11eb-186c-5195b661bc2a
length(samples)

# ╔═╡ f9aa8a56-92be-11eb-2659-33c40c1dedb2
samples

# ╔═╡ e1b59b2c-92b7-11eb-0252-a17298bd3c41
mean(samples2)

# ╔═╡ e6f4fe20-92b7-11eb-1fb0-a12b163d8f05
median(samples2)

# ╔═╡ be3ab114-92b7-11eb-1cef-b1006d4847f4
begin
	histogram(samples2,bins=10,normalize=:pdf)
end

# ╔═╡ be0bb316-92bc-11eb-07a0-09044d8ef360
begin
	density(samples2)
	scatter!([median(samples2)],[0],label="median")
	scatter!([mean(samples2)],[0],label="mean")
	scatter!([mode(samples2)],[0],label="mode")
	#plot!(d_mean, samples2, label="Mean", line=(4, :dash, :green))
	
end

# ╔═╡ e9db39c6-92b0-11eb-301f-ef5ac361efa9
md"Q4. (1 point) Consider again the uniform distribution U in the range [0, 1]. Create 10,000 random samples with each sample of 30 elements from U. For each sample calculate the range. Now, these 10,000 values of range can be treated as a random sample itself. Plot the histogram of this range and mark the mean, median, and mode. "

# ╔═╡ 2c91256e-92c5-11eb-3d73-dd805d379b63
begin
	random_arr = [[rand(Uniform(0,1)) for _ in 1:30] for _ in 1:10000]
	range_arr=[maximum(random_arr[i])-minimum(random_arr[i]) for i in 1:10000]
end

# ╔═╡ ed328e66-92c5-11eb-0622-b74bedc6a37c
begin	
	histogram(range_arr,nbins=20,normalize=:pdf)
	scatter!([median(range_arr)],[0],label="median")
	scatter!([mean(range_arr)],[0],label="mean")
	scatter!([mode(range_arr)],[0],label="mode")
end

# ╔═╡ 05c703c6-92c6-11eb-2252-875f08cdf573
mean(range_arr)

# ╔═╡ 0cda6264-92c6-11eb-00fd-c1dafa482ee4
median(range_arr)

# ╔═╡ 182029da-92c6-11eb-13ee-5df2d754ecd0
mode(range_arr)

# ╔═╡ 358ea4f8-92c6-11eb-1aea-b7305b59aa66
begin
	density(range_arr)
	scatter!([median(range_arr)],[0],label="median")
	scatter!([mean(range_arr)],[0],label="mean")
	scatter!([mode(range_arr)],[0],label="mode")
	#plot!(d_mean, samples2, label="Mean", line=(4, :dash, :green))
	
end

# ╔═╡ 6843488c-9561-11eb-146b-5b12fb65b94c
md"Q5.Now that you have the computational insight, let us try out a theoretical problem. Again if you are sampling 30 variates from U, what is the probability that the range of the sample is greater than some threshold θ in the interval [0, 1].  (Hint: Approach by first bounding the minimum value say u, then the range being greater than θ implies that the maximum value is greater than u + θ, ...). "

# ╔═╡ 634d07be-9561-11eb-3ea7-939b88c36468
md"
```math
\mathrm{Pr}\large(Range\large) =
\mathrm{Pr}\large(\max(x_1, x_2, \ldots, x_n)-min(x_1, x_2, \ldots, x_n) > tetha\large)
```

"

# ╔═╡ 4eb0e90a-9562-11eb-3fd5-2b2faa17eee2
md"Let minimum be v"

# ╔═╡ 352503b0-9562-11eb-00fc-77fdbdc5077a
md"
```math
\mathrm{Pr}\large(\max(x_1, x_2, \ldots, x_n) - v> tetha\large) =  \mathrm{Pr}\large(\max(x_1, x_2, \ldots, x_n) > tetha+v\large)
```
"

# ╔═╡ 7ac24b38-9562-11eb-043f-694bcf4b1e20
md"
```math
\mathrm{Pr}\large(\max(x_1, x_2, \ldots, x_n) > tetha+v\large) =  1 - \prod_{i = 1}^n \mathrm{Pr}(x_i \leq v+tetha) 
```
"

# ╔═╡ cc322f7e-9562-11eb-194e-f3d9fcc78d1f
md"
```math
1 - \prod_{i = 1}^n \mathrm{Pr}(x_i \leq v+tetha) 
= 1 - (v+tetha)^n
```
"

# ╔═╡ 030d0960-9563-11eb-1bde-bb60176e7910
md"
```math
\mathrm{Pr}\large(\max(x_1, x_2, \ldots, x_n) - v> tetha\large) 
= 1 - (v+tetha)^n
```
"

# ╔═╡ 25378204-9563-11eb-1f88-a76f6948bd5a
md" so tetha+v has to be between 0 to 1"

# ╔═╡ 546e6dee-9563-11eb-1ac3-df02ba2d83c7
md"
```math
\mathrm{Pr}\large(Range> tetha\large) 
= \int_{0}^{1-tetha} (1 - (v+tetha)^n )dv
```
"

# ╔═╡ 047b41f8-90a5-11eb-2abe-bda5a3cf1e90
md"Q6.In the last assignment, you had worked with the CoViD data for Indian states. Using that data, let us try out a problem in correlation. 

By aggregating data over weeks, compute the weekly total number of new cases reported in each state, i.e., generate a table with rows as distinct week numbers and one column per state with the total number of new cases in that week.

For each pair of states compute the covariance, Pearson’s coefficient of correlation, and Spearman’s coefficient of correlation. Represent this as three separate heat maps, where both axes of the plot are the states.

What do you observe? Are the statistics agreeing?
"

# ╔═╡ cb9296b6-90a4-11eb-3604-41264e092199
import HTTP

# ╔═╡ e661eb22-90a4-11eb-1f19-c73818141c2f
import JSON

# ╔═╡ 119ae874-90a6-11eb-2832-83da5020cefe
import CSV

# ╔═╡ 20b95684-90ad-11eb-2429-bdf87d4f5c3e
begin
	f = CSV.File(HTTP.get("https://api.covid19india.org/csv/latest/states.csv").body)
	df=DataFrame(f)
	df.Weekno = Dates.days.(df.Date .- Date(2020, 1, 19)) .÷ 7
	gdf = groupby(df, [:State,:Weekno])
	df_combined=combine(gdf, :Confirmed => sum)
	Output_df=unstack(df_combined, :Weekno, :State, :Confirmed_sum)
end

# ╔═╡ 8e6904e2-9512-11eb-309a-c3d418a2d153
begin
	KlUsingSummation=[]
	KlUsingIntegration=[]
	for i in 1:5
		Q = TDist(i)
		push!(KlUsingSummation,klDivergence(P,Q))
		f(x)=pdf(P,x)*(log(pdf(P,x)/pdf(Q,x)))
		push!(KlUsingIntegration,quadgk(f, -10, 10)[1])
	end
end


# ╔═╡ b53dd7e6-9512-11eb-2759-81df5415a213
KlUsingSummation

# ╔═╡ baad9bc6-9512-11eb-15ba-118106755a13
KlUsingIntegration

# ╔═╡ 82577d7e-9456-11eb-3c24-43ba7c723d9a
df6=select(Output_df, Not(:Weekno))

# ╔═╡ fdff3c76-94fa-11eb-24f8-3748c14f845a
names(df6)

# ╔═╡ 1db26f74-94f7-11eb-224e-c3c120188edc
function covmat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		    sx, sy = skipmissings(c1, c2)
		    if !isempty(collect(sx)) && !isempty(collect(sx))
		   	 t[i, j] = cov(collect(sx), collect(sy))
			end
	   end
   end
   return t
   end;

# ╔═╡ e45b7eba-90ae-11eb-0c3c-29f806911bd7
Covariance=covmat(df6)

# ╔═╡ d9b27dd0-94f8-11eb-2707-3de604e94e0a
function cormat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		    sx, sy = skipmissings(c1, c2)
		    if !isempty(collect(sx)) && !isempty(collect(sx))
		   		t[i, j] = cor(collect(sx), collect(sy))
			end
	   end
   end
   return t
   end;

# ╔═╡ 312dd1ae-94f9-11eb-2782-e90cafc345fb
PearsonCorrelation=cormat(df6)

# ╔═╡ 976c6c46-94f9-11eb-19da-5b4e7f262639
findpos(arr) = [indexin(arr[i], sort(arr))[1] for i in 1:length(arr)]

# ╔═╡ a67c82a0-94f9-11eb-36b7-7510024fedfa
function spearcormat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		    sx, sy = skipmissings(c1, c2)
		    if !isempty(collect(sx)) && !isempty(collect(sx))
		   		t[i, j] = cor(findpos(collect(sx)), findpos(collect(sy)))
			end
	   end
   end
   return t
   end;

# ╔═╡ 7c26c4ce-9510-11eb-03cb-b37442319015
default(size =(600, 300))

# ╔═╡ dbe9538e-94f9-11eb-0f24-672eb1bc5f1b
spearmanCorrelation=spearcormat(df6)

# ╔═╡ 0600325c-9511-11eb-3a34-0be4c7c8ea0f
names(df6)

# ╔═╡ b4072700-94fa-11eb-3af4-63eb961ab54a
heatmap(names(df6),names(df6) , spearmanCorrelation)

# ╔═╡ 40492022-9511-11eb-1f18-3fadb7ca7213
heatmap(names(df6),names(df6) , PearsonCorrelation)

# ╔═╡ 5dd3480c-9511-11eb-14ad-8155984fab9f
heatmap(names(df6),names(df6) , Covariance)

# ╔═╡ 88cc71ce-90ab-11eb-1af0-238f5b380219
#df.Weekno = Dates.days.(df.Date .- Date(2020, 1, 19)) .÷ 7

# ╔═╡ bbbb8188-90ab-11eb-0f14-71d5d9e4d858
#df

# ╔═╡ 4f57bcda-90a8-11eb-0944-8183421e169b
#gdf = groupby(df, [:State,:weekno])

# ╔═╡ 1894e85e-90ac-11eb-078e-e1c7b8ba70b2
#gdf[10]

# ╔═╡ 43c3303a-90ac-11eb-2d69-b5c029581eca
#df_combined=combine(gdf, :Confirmed => sum)

# ╔═╡ d7f2a97a-90ac-11eb-1040-afc8b9987410
#unstack(df_combined, :weekno, :State, :Confirmed_sum)

# ╔═╡ 301a2ee6-90aa-11eb-0df5-07fb1bc33a3d
#df.yearMonth = getproperty.(match.(r"[0-9]*-[0-9][0-9]",df.Date), :match)

# ╔═╡ 81bed7a4-93d6-11eb-110c-af0b36e10022
md"Q7. (2 points) You will soon realise that statistics is often a tale of tails. So here is a tail’s up:

Write a Julia function OneSidedTail such that the percentile of standard normal distribution computed at OneSidedTail(x) is 100 - x, where, 0 < x < 100. 
Repeated the above process with Student’s T distribution with v = 10.

For x = 95, visualise the output of the two functions with a plot. Hint: think of area under curves. "

# ╔═╡ 52c05d84-9448-11eb-2778-ff0ae24b466c
quantile(Normal(0,1), .50)

# ╔═╡ 93c61ec2-9448-11eb-240b-4bc187a25f44
OneSidedTail(x)=quantile(Normal(0,1), 1-(x/100))

# ╔═╡ b1f4dc94-9448-11eb-3f1a-614336a49435
arrayNormal = OneSidedTail.(0:100)

# ╔═╡ 3772ccbe-9449-11eb-3078-196c68407c59
OneSidedTail_Tdistribution(x)=quantile(TDist(10), 1-(x/100))

# ╔═╡ 4e9c1d9e-9449-11eb-07df-6d00aca9e80f
arrayTdistribution=OneSidedTail_Tdistribution.(0:100)

# ╔═╡ 8eee3334-9449-11eb-0ed3-bd55372fc981
begin
	scatter(0:100,arrayNormal,label="Normal distribution")
	scatter!(0:100,arrayTdistribution,label="T distribution")
end

# ╔═╡ 84afad70-944a-11eb-134d-25e2a9a96840
begin
	p1=plot(-5:0.1:5, [pdf(Normal(0,1), x) for x in -5:0.1:5],label=false,title="Normal distribution", line=3)
	p1=plot!(-5:0.1:OneSidedTail(95), [pdf(Normal(0,1), x) for x in -5:0.1:OneSidedTail(95)], label=false, line=3,fill=(0, :blue, 0.3))
	p2=plot(-5:0.1:5, [pdf(TDist(10), x) for x in -5:0.1:5], label=false,title="T distribution", line=3)
	p2=plot!(-5:0.1:OneSidedTail_Tdistribution(95), [pdf(TDist(10), x) for x in -5:0.1:OneSidedTail_Tdistribution(95)], label=false, line=3,fill=(0, :blue, 0.3))
	plot(p1,p2,layout=2)
end

# ╔═╡ 2e66baba-944c-11eb-387d-a91063f31145
begin
	plot(-5:0.1:5, [pdf(TDist(10), x) for x in -5:0.1:5], label=false, line=3)
	plot!(-5:0.1:OneSidedTail_Tdistribution(95), [pdf(TDist(10), x) for x in -5:0.1:OneSidedTail_Tdistribution(95)], label=false, line=3,fill=(0, :blue, 0.3))
end

# ╔═╡ Cell order:
# ╠═7e810192-92b0-11eb-33fb-0dade801e855
# ╠═39021be0-9512-11eb-05ac-8364231a3682
# ╟─55e7ac38-944d-11eb-3b2d-cdeea518f1d2
# ╠═6b2d35e0-944d-11eb-20d6-33ec690694d0
# ╠═905089b0-9512-11eb-30d4-19dc636da944
# ╠═c480c0f6-9512-11eb-0cae-a578138f7c65
# ╠═269440a2-9512-11eb-29bd-8b1018e2a53c
# ╠═8e6904e2-9512-11eb-309a-c3d418a2d153
# ╠═b53dd7e6-9512-11eb-2759-81df5415a213
# ╠═baad9bc6-9512-11eb-15ba-118106755a13
# ╟─ce34494e-9512-11eb-2ea1-451ad03b4b5b
# ╠═14c7609c-9513-11eb-1ec5-89976e8c7724
# ╠═2fe219a8-9513-11eb-06bd-63ceaf186dec
# ╠═5a034c48-9513-11eb-0d2b-617bd05588d7
# ╠═f20a0c94-9519-11eb-1d9b-fdd68485afac
# ╠═ba5d4ada-9568-11eb-2e38-35b761903449
# ╠═2ace66c8-9569-11eb-0ebe-c74d62353bc5
# ╠═c07d3ea4-9516-11eb-19b5-970c4feafa14
# ╠═39fdc0e6-9567-11eb-3e96-d7843d2f60fd
# ╠═e70cc794-9569-11eb-1b3f-651842ac9cd4
# ╠═5494f62e-956a-11eb-120f-2d1fc0b59f6b
# ╠═b6d1c96c-9519-11eb-3f7f-6d3cd178019a
# ╟─0ba271c4-92b0-11eb-0793-f567d8f4ab7c
# ╠═cf64da6a-92c2-11eb-32c9-f37f942d7abf
# ╠═1426446c-92ba-11eb-186c-5195b661bc2a
# ╠═f9aa8a56-92be-11eb-2659-33c40c1dedb2
# ╠═e1b59b2c-92b7-11eb-0252-a17298bd3c41
# ╠═e6f4fe20-92b7-11eb-1fb0-a12b163d8f05
# ╠═be3ab114-92b7-11eb-1cef-b1006d4847f4
# ╠═be0bb316-92bc-11eb-07a0-09044d8ef360
# ╟─e9db39c6-92b0-11eb-301f-ef5ac361efa9
# ╠═2c91256e-92c5-11eb-3d73-dd805d379b63
# ╠═ed328e66-92c5-11eb-0622-b74bedc6a37c
# ╠═05c703c6-92c6-11eb-2252-875f08cdf573
# ╠═0cda6264-92c6-11eb-00fd-c1dafa482ee4
# ╠═182029da-92c6-11eb-13ee-5df2d754ecd0
# ╠═358ea4f8-92c6-11eb-1aea-b7305b59aa66
# ╟─6843488c-9561-11eb-146b-5b12fb65b94c
# ╟─634d07be-9561-11eb-3ea7-939b88c36468
# ╟─4eb0e90a-9562-11eb-3fd5-2b2faa17eee2
# ╟─352503b0-9562-11eb-00fc-77fdbdc5077a
# ╟─7ac24b38-9562-11eb-043f-694bcf4b1e20
# ╟─cc322f7e-9562-11eb-194e-f3d9fcc78d1f
# ╟─030d0960-9563-11eb-1bde-bb60176e7910
# ╟─25378204-9563-11eb-1f88-a76f6948bd5a
# ╟─546e6dee-9563-11eb-1ac3-df02ba2d83c7
# ╟─047b41f8-90a5-11eb-2abe-bda5a3cf1e90
# ╠═cb9296b6-90a4-11eb-3604-41264e092199
# ╠═e661eb22-90a4-11eb-1f19-c73818141c2f
# ╠═119ae874-90a6-11eb-2832-83da5020cefe
# ╠═387a18ca-90a6-11eb-33f9-c524bd629dde
# ╠═a98761a4-90af-11eb-0be1-051a211749fb
# ╠═86620fd4-90a9-11eb-0de3-1dcbdf80939b
# ╠═20b95684-90ad-11eb-2429-bdf87d4f5c3e
# ╠═82577d7e-9456-11eb-3c24-43ba7c723d9a
# ╠═fdff3c76-94fa-11eb-24f8-3748c14f845a
# ╠═1db26f74-94f7-11eb-224e-c3c120188edc
# ╠═e45b7eba-90ae-11eb-0c3c-29f806911bd7
# ╠═d9b27dd0-94f8-11eb-2707-3de604e94e0a
# ╠═312dd1ae-94f9-11eb-2782-e90cafc345fb
# ╠═976c6c46-94f9-11eb-19da-5b4e7f262639
# ╠═a67c82a0-94f9-11eb-36b7-7510024fedfa
# ╠═7c26c4ce-9510-11eb-03cb-b37442319015
# ╠═dbe9538e-94f9-11eb-0f24-672eb1bc5f1b
# ╠═0600325c-9511-11eb-3a34-0be4c7c8ea0f
# ╠═b4072700-94fa-11eb-3af4-63eb961ab54a
# ╠═40492022-9511-11eb-1f18-3fadb7ca7213
# ╠═5dd3480c-9511-11eb-14ad-8155984fab9f
# ╠═88cc71ce-90ab-11eb-1af0-238f5b380219
# ╠═bbbb8188-90ab-11eb-0f14-71d5d9e4d858
# ╠═4f57bcda-90a8-11eb-0944-8183421e169b
# ╠═1894e85e-90ac-11eb-078e-e1c7b8ba70b2
# ╠═43c3303a-90ac-11eb-2d69-b5c029581eca
# ╠═d7f2a97a-90ac-11eb-1040-afc8b9987410
# ╠═301a2ee6-90aa-11eb-0df5-07fb1bc33a3d
# ╟─81bed7a4-93d6-11eb-110c-af0b36e10022
# ╠═52c05d84-9448-11eb-2778-ff0ae24b466c
# ╠═93c61ec2-9448-11eb-240b-4bc187a25f44
# ╠═b1f4dc94-9448-11eb-3f1a-614336a49435
# ╠═3772ccbe-9449-11eb-3078-196c68407c59
# ╠═4e9c1d9e-9449-11eb-07df-6d00aca9e80f
# ╠═8eee3334-9449-11eb-0ed3-bd55372fc981
# ╠═84afad70-944a-11eb-134d-25e2a9a96840
# ╠═2e66baba-944c-11eb-387d-a91063f31145
