### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ f57d161c-7917-11eb-2f5f-1bbd2d765dc2
using DataFrames

# ╔═╡ e80b2cc2-7b46-11eb-02b2-d3ff44118ccf
using Dates

# ╔═╡ eebea748-7c06-11eb-2824-d5dbd6f03eae
using HTTP

# ╔═╡ 8799c95e-7c07-11eb-239f-d1f1eaf8c491
using JSON

# ╔═╡ ee401100-7cd8-11eb-17a0-d5067dc03ecf
using Statistics

# ╔═╡ fe29fbda-7e86-11eb-2346-49e920c6633f
using StatsPlots

# ╔═╡ ed300f64-7f13-11eb-2436-83bce34c643d
md"Q1. (2 points) In the first 3 questions, we will use datasets from the Tidy Data note. In each question, you will find two datasets - called untidy and tidy. You are required to (a) create a Julia dataframe manually to replicate the untidy data, and (b) transform the untidy dataset into the tidy dataset using different commands in Julia that we saw such as select, transform, groupby, etc. For creating the untidy dataset, you are free to use your own values to fill up the dataset - beyond what is indicated in the pictures.

In this first question, notice that there are multiple columns in the untidy data. This is the wide format. You are required to reshape it into the narrow format."

# ╔═╡ 4906be04-791e-11eb-00ab-c7f3640a74bd
begin
	df1 = DataFrame()
	df1.religion = ["Agnostic","Atheist","Buddhist","Catholic","Don't know/refused","Evangelical Prot","Hindu","Historically Black Prot","Jehovah's Witness","Jewish"]
	df1."<\$10k" = [27,12,27,418,15,575,1,228,20,19]
	df1."\$10-20k" = [34,27,21,617,14,869,9,244,27,19]
	df1."\$20-30k" = [60,37,21,617,14,869,9,244,27,19]
	df1."\$30-40k" = [34,77,21,56,14,454,34,23,2343,159]
	df1."\$40-50k" = [35,37,21,137,16,424,44,484,5784,18]
	df1."\$50-75k" = [90,657,231,6117,164,69,59,44,77,69]
	df1."\$75-80k" = [34,77,21,56,14,454,34,23,2343,159]
	df1."\$80-90k" = [35,37,21,137,16,424,44,484,5784,18]
	df1."\$90-100k" = [90,657,231,6117,164,69,59,44,77,68]
	df1
end

# ╔═╡ 07d2c586-7aba-11eb-17d2-dbcd70521b58
begin
	df1_stacked=DataFrames.stack(df1, 2:10 , :religion)
	df1_sorted=sort(df1_stacked,:religion)
	rename!(df1_sorted, Dict(:variable => :income))
	rename!(df1_sorted, Dict(:value => :freq))
end

# ╔═╡ 43d556fa-7f15-11eb-055c-178a32c80806
md"Q2. (2 points) In this second question, notice that the data is missing. You can put in dummy data for the minimum and maximum temperatures for different days. Missing data should be modelled using missing in Julia. This data is to be transformed into a tidy dataset where each date is a single row. Notice that the date column in the tidy dataframe is a combination of the year, month, and date"

# ╔═╡ 2c53e540-7b15-11eb-2f92-23839ecfe94c
begin
	df2_untidy = DataFrame(Id = String[], year = Int[],month = Int[],element = [],d1=Int[],d2=Int[],d3=Int[],d4=Int[],d5=Int[],d6=Int[],d7=Int[],d8=Int[],d9=Int[],d10=Int[],d11=Int[],d12=Int[],d13=Int[],d14=Int[],d15=Int[],d16=Int[],d17=Int[],d18=Int[],d19=Int[],d20=Int[],d21=Int[],d22=Int[],d23=Int[],d24=Int[],d25=Int[],d26=Int[],d27=Int[],d28=Int[],d29=Int[],d30=Int[])
	allowmissing!(df2_untidy)
	push!(df2_untidy, ("MX17004",2010,1,"tmax",27,missing,28,missing,missing,42,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,1,"tmin",13,missing,14,missing,missing,12,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,2,"tmax",missing,34,24,missing,missing,53,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,2,"tmin",missing,11,16,missing,missing,21,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,3,"tmax",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,3,"tmin",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,4,"tmin",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,4,"tmin",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,5,"tmax",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,5,"tmin",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,6,"tmax",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,6,"tmin",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,7,"tmax",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	push!(df2_untidy, ("MX17004",2010,7,"tmin",missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing,missing))
	df2_untidy
end

# ╔═╡ 0e058872-7b57-11eb-1276-6d6ca3550b08
begin
	df2_stacked=DataFrames.stack(df2_untidy, 5:34)
	dropmissing!(df2_stacked)
	df2_select=select(df2_stacked,:Id, [:year,:month,:variable] => ByRow((year,month,variable)-> Dates.Date(year,month,(parse(Int64, SubString(variable, 2, length(variable)))))) => :date,:element,:value)
	df2_tidy=unstack(df2_select,:element,:value)
	sort(df2_tidy,:date)
end

# ╔═╡ 886c6538-7f15-11eb-3c46-335ba5506902
md"Q3. (2 points) In this third question, you will be generating two dataframes as a part of the tidy dataset. We will separate columns that are not dependent on time from those that vary from week-to-week. Notice that week  is not included in the tidy data since the information is already captured in the date column."

# ╔═╡ b9c6edca-7bef-11eb-00ae-3f92a0a68b17
begin
	df3_untidy = DataFrame(year = Int[], artist = String[], time=String[],track=String[],date=Date[],week=Int[],rank=Int[])
	push!(df3_untidy, (2000 ,"2 Pac" ,"4:22" ,"Baby Don’t Cry", Dates.Date(2000,02,26), 1, 87)) 
	push!(df3_untidy, (2000 ,"2 Pac" ,"4:22" ,"Baby Don’t Cry", Dates.Date(2000,03,04), 2, 82))
	push!(df3_untidy, (2000 ,"2 Pac" ,"4:22" ,"Baby Don’t Cry", Dates.Date(2000,03,11), 3, 72))
	push!(df3_untidy, (2000 ,"2 Pac" ,"4:22" ,"Baby Don’t Cry", Dates.Date(2000,03,18), 4, 77))
	push!(df3_untidy, (2000 ,"2 Pac" ,"4:22" ,"Baby Don’t Cry", Dates.Date(2000,03,25), 5, 87))
	push!(df3_untidy, (2000 ,"2 Pac" ,"4:22" ,"Baby Don’t Cry", Dates.Date(2000,04,01), 6, 94))
	push!(df3_untidy, (2000 ,"2 Pac" ,"4:22" ,"Baby Don’t Cry", Dates.Date(2000,04,08), 7, 99))
	push!(df3_untidy, (2000,"2Ge+her","3:15", "The Hardest Part Of ...", Dates.Date(2000,09,02), 1,91))
	push!(df3_untidy, (2000,"2Ge+her","3:15", "The Hardest Part Of ...", Dates.Date(2000,09,09), 2,87))
	push!(df3_untidy, (2000,"2Ge+her","3:15", "The Hardest Part Of ...", Dates.Date(2000,09,16), 3,92))
	push!(df3_untidy, (2000,"3 Doors Down", "3:53","Kryptonite",
Dates.Date(2000,04,08), 1, 81))
	push!(df3_untidy, (2000,"3 Doors Down", "3:53","Kryptonite",
Dates.Date(2000,04,15), 2, 70))
	push!(df3_untidy, (2000,"3 Doors Down", "3:53","Kryptonite",
Dates.Date(2000,04,22), 3, 68))
	push!(df3_untidy, (2000,"3 Doors Down", "3:53","Kryptonite",
Dates.Date(2000,04,29), 4, 67))
	push!(df3_untidy, (2000,"3 Doors Down", "3:53","Kryptonite",
Dates.Date(2000,05,06), 5, 66))
	push!(df3_untidy, (2000,"3 Doors Down", "3:53","manideeptrack",
Dates.Date(2000,05,06), 1, 66))
	df3_untidy
end

# ╔═╡ ecbc2b18-7c04-11eb-3c9a-1381034a5552
begin
	gdf = groupby(df3_untidy, :track)
	df3_tidy1=insertcols!(unique(select(gdf,:artist,:track,:time)), 1, :Id => 1:length(gdf),makeunique=false)
	df3_tidy2=select(innerjoin( df3_untidy,df3_tidy1, on = :track,makeunique=true),:Id,:date,:rank)
	df3_tidy1
end

# ╔═╡ 0085af34-7bf6-11eb-0fdc-5198cb0e2a36
df3_tidy2

# ╔═╡ e385f1c8-7f18-11eb-174c-09632186bb61
md"Q4. (2 points) Let us now move on beyond tidy data. In this question, you are required to access the dataset on CoViD cases reported in the country as available from this API.  You are required to load this dataset into a dataframe of Julia. (You will have to figure out the HTTP request and JSON to dataframe conversion). After that, you are required to transform the columns and use split-apply-combine to report the aggregate number of confirmed, deceased, and recovered cases in each calendar month. "

# ╔═╡ c9c89662-7c06-11eb-0f62-7d155a18a4bd
begin
	r = HTTP.request("GET", "https://api.covid19india.org/data.json"; verbose=3)
	data=String(r.body)
	a=JSON.Parser.parse(data)
	df4_1=reduce(vcat, DataFrame.(a["cases_time_series"]))
	df5=reduce(vcat, DataFrame.(a["cases_time_series"]))
	df4_1
end

# ╔═╡ 4091bc98-7cd8-11eb-1aba-f34ed1d6b8a6
begin
	df4_1.yearMonth = getproperty.(match.(r"[0-9]*-[0-9][0-9]",df4_1.dateymd), :match)
	df4_1[!,:dailyconfirmed] = [parse(Int,x) for x in df4_1[!,:dailyconfirmed]] 
	df4_1[!,:dailydeceased] = [parse(Int,x) for x in df4_1[!,:dailydeceased]] 
	df4_1[!,:dailyrecovered] = [parse(Int,x) for x in df4_1[!,:dailyrecovered]] 
	gdf4 = groupby(df4_1, :yearMonth)
	combine(gdf4, :dailyconfirmed .=>sum => :aggregatedDailyconfirmed,:dailydeceased .=>sum => :aggregatedDailydeceased,:dailyrecovered .=>sum => :aggregatedDailyrecovered)
end

# ╔═╡ 8503c2e8-7f19-11eb-1ed8-6d66b9590d92
md"Q5. (2 points) In this last question, we will try out a slightly more complex transformation on the dataset. If you plot the number of cases (in any of the three categories) across time, you would find the plot is not smooth, i.e., values vary from day to day with small unexpected variations. One way to smooth such plots, yet not lose the trend over longer periods of time is to compute a moving average. You are required to compute 7 preceding days’ moving average for each of the three columns - confirmed, deceased, and recovered as three new columns. For each of these three columns, you are required to visualise separate plots showing both the original values and the values smoothened with the moving average. Notice that the moving average for the first six days is not defined and can be left blank."

# ╔═╡ 3ad945e2-7e85-11eb-04f5-ad693920d0da
df5

# ╔═╡ d7ed8a4a-7f19-11eb-21ac-7576f7449a9d
begin
	df5[!,:dailyconfirmed] = [parse(Int,x) for x in df5[!,:dailyconfirmed]] 
	df5[!,:dailydeceased] = [parse(Int,x) for x in df5[!,:dailydeceased]] 
	df5[!,:dailyrecovered] = [parse(Int,x) for x in df5[!,:dailyrecovered]] 
end

# ╔═╡ 6d01483a-7e85-11eb-365e-312959c090f3
begin
	df5.movingAvgDailyConfirmed= [x<7 ? missing :
		(sum(df5[!,:dailyconfirmed][x-6:x]))/7  for x in 1:length(df5[!,:dailyconfirmed])]
	df5.movingAvgDailyDeceased= [x<7 ? missing :
		(sum(df5[!,:dailydeceased][x-6:x]))/7  for x in 1:length(df5[!,:dailydeceased])]
	df5.movingAvgDailyRecovered= [x<7 ? missing :
		(sum(df5[!,:dailyrecovered][x-6:x]))/7  for x in 1:length(df5[!,:dailyrecovered])]
end

# ╔═╡ c6a87d44-7e8b-11eb-3259-e7423458743e
df5

# ╔═╡ 14d17e62-7e87-11eb-364b-7573c9553d8d
begin
	plt1=plot(df5[!,:dailyconfirmed],xlabel="days",ylabel="no of confirmed")
	plt2 = plot(df5.movingAvgDailyConfirmed, linewidth=2, color=:red,xlabel="days",ylabel="no of confirmed")
	plot(plt1,plt2)
end

# ╔═╡ 4e029416-7f1b-11eb-02e6-5f287bca17a2
begin
	plot(df5[!,:dailyconfirmed],xlabel="days",ylabel="no of confirmed")
 	plot!(df5.movingAvgDailyConfirmed, linewidth=2, color=:red,xlabel="days",ylabel="no of confirmed")
end

# ╔═╡ 37898978-7e8b-11eb-0f55-1f5a6b173bda
begin
	plt3=plot(df5[!,:dailydeceased],xlabel="days",ylabel="no of deceased")
	plt4 = plot(df5.movingAvgDailyDeceased, linewidth=2, color=:red,xlabel="days",ylabel="no of deceased")
	plot(plt3,plt4)
end

# ╔═╡ 6d32128a-7f1b-11eb-0cb5-c95afb23b2a6
begin
	plot(df5[!,:dailydeceased],xlabel="days",ylabel="no of deceased")
	plot!(df5.movingAvgDailyDeceased, linewidth=2, color=:red,xlabel="days",ylabel="no of deceased")
end

# ╔═╡ 387d22a4-7e8b-11eb-17ec-03ee48b938d7
begin
	plt5=plot(df5[!,:dailyrecovered],xlabel="days",ylabel="no of recovered")
	plt6 = plot(df5.movingAvgDailyRecovered, linewidth=2, color=:red,xlabel="days",ylabel="no of recovered")
	plot(plt5,plt6)
end

# ╔═╡ 8887f2b6-7f1b-11eb-0dc7-094a6180917c
begin
	plot(df5[!,:dailyrecovered],xlabel="days",ylabel="no of recovered")
	plot!(df5.movingAvgDailyRecovered, linewidth=2, color=:red,xlabel="days",ylabel="no of recovered")
end

# ╔═╡ Cell order:
# ╠═f57d161c-7917-11eb-2f5f-1bbd2d765dc2
# ╟─ed300f64-7f13-11eb-2436-83bce34c643d
# ╠═4906be04-791e-11eb-00ab-c7f3640a74bd
# ╠═07d2c586-7aba-11eb-17d2-dbcd70521b58
# ╟─43d556fa-7f15-11eb-055c-178a32c80806
# ╟─2c53e540-7b15-11eb-2f92-23839ecfe94c
# ╠═0e058872-7b57-11eb-1276-6d6ca3550b08
# ╠═886c6538-7f15-11eb-3c46-335ba5506902
# ╠═e80b2cc2-7b46-11eb-02b2-d3ff44118ccf
# ╠═b9c6edca-7bef-11eb-00ae-3f92a0a68b17
# ╠═ecbc2b18-7c04-11eb-3c9a-1381034a5552
# ╠═0085af34-7bf6-11eb-0fdc-5198cb0e2a36
# ╟─e385f1c8-7f18-11eb-174c-09632186bb61
# ╠═eebea748-7c06-11eb-2824-d5dbd6f03eae
# ╠═8799c95e-7c07-11eb-239f-d1f1eaf8c491
# ╠═c9c89662-7c06-11eb-0f62-7d155a18a4bd
# ╠═ee401100-7cd8-11eb-17a0-d5067dc03ecf
# ╠═4091bc98-7cd8-11eb-1aba-f34ed1d6b8a6
# ╟─8503c2e8-7f19-11eb-1ed8-6d66b9590d92
# ╠═3ad945e2-7e85-11eb-04f5-ad693920d0da
# ╠═d7ed8a4a-7f19-11eb-21ac-7576f7449a9d
# ╠═6d01483a-7e85-11eb-365e-312959c090f3
# ╠═fe29fbda-7e86-11eb-2346-49e920c6633f
# ╠═c6a87d44-7e8b-11eb-3259-e7423458743e
# ╠═14d17e62-7e87-11eb-364b-7573c9553d8d
# ╠═4e029416-7f1b-11eb-02e6-5f287bca17a2
# ╠═37898978-7e8b-11eb-0f55-1f5a6b173bda
# ╠═6d32128a-7f1b-11eb-0cb5-c95afb23b2a6
# ╠═387d22a4-7e8b-11eb-17ec-03ee48b938d7
# ╠═8887f2b6-7f1b-11eb-0dc7-094a6180917c
