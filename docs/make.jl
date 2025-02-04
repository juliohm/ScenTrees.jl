using Documenter, ScenTrees

#const ASSETS = readdir(joinpath(@__DIR__, "src", "assets"))

isCI = get(ENV, "CI", nothing) == "true" #Travis populates this env variable by default

makedocs(
	sitename =  "ScenTrees.jl",
	authors = "Kipngeno Kirui",
	clean = true,
	doctest = true,
	format = Documenter.HTML(prettyurls = isCI),		
	pages = ["Home" => "index.md",
		"Tutorials" => Any["tutorial/tutorial1.md",
				    "tutorial/tutorial2.md",
				    "tutorial/tutorial3.md",
				    "tutorial/tutorial31.md",
				    "tutorial/tutorial4.md",
				    "tutorial/tutorial41.md",
				    "tutorial/tutorial5.md"
				] 
		]
)

if isCI
    deploydocs(repo = "github.com/kirui93/ScenTrees.jl.git")
end
