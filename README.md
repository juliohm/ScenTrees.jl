<a name="logo"/>
<div align="center">
<img src="docs/src/assets/logo.png" height="130"></img>
</a>
</div>

| **Build and Test Status**         | **Coverage**                          | **Documentation**             |
|:---------------------------------:|:-------------------------------------:|:-----------------------------:|
|[![Build and Test Status](https://travis-ci.com/kirui93/ScenTrees.jl.svg?branch=master)](https://travis-ci.com/kirui93/ScenTrees.jl) | [![Coverage](https://codecov.io/gh/kirui93/ScenTrees.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/kirui93/ScenTrees.jl) | [![Documentation](https://img.shields.io/badge/dos-latest-blue.svg)](https://kirui93.github.io/ScenTrees.jl/latest/)| 

# ScenTrees.jl

`ScenTrees.jl` is a Julia library for generating and improving scenario trees and scenario lattices for multistage stochastic optimization problems using _stochastic approximation_. It is totally written in Julia programiing language. This package provides functions for generating scenario trees and scenario lattices from stochastic processes and stochastic data.

We provide two important features at the moment:

- Stochastic approximation of stochastic processes by scenario trees and scenario lattices
- Estimating trajectories from stochastic data using kernel density estimation.
    
The data estimated in (2) above can be used in (1) to generate scenario trees and scenario lattices.

The stochastic approximation procedure in `ScenTrees.jl` library follows from the framework provided by [Pflug and Pichler(2015)](https://doi.org/10.1007/s10589-015-9758-0).

*N/B* - _This package is actively developed and therefore new improvements and new features are continuously added._

## Installation

The following is the standard procedure to add `ScenTrees.jl` and load it available for usage:

```julia
julia> using Pkg
julia> Pkg.add("https://github.com/kirui93/ScenTrees.jl.git")
julia> using ScenTrees
```

Having followed the above procedure the various functions in the library will be available for usage.

To use `ScenTrees.jl`, you need to have Julia 1.0 and above. This library was developed in Julia 1.0.4 and tested using the Julia standard framework. It has been tested for Julia versions 1.0 and above and nightly for the latest release of Julia in Linux and OSX distributions.

## Documentation 

If you have installed ScenTrees.jl using the above procedure then you will have the latest release of this library. To access the documentation just click on this link [Documentation](https://kirui93.github.io/ScenTrees.jl/latest/). Here you can get the description of the various functions in the package and also different examples for the different features in the library. We advise the user to read the documentation to get a general knowledge of how the package works and the various functions that this package provides.

## Example of Usage

After installing the ScenTrees.jl library, you can use it as in the following examples:

1. Consider the Gaussian random walk process in 4 stages. This process is already available in the library and can just be called by `GaussianSamplePath1D()` for 1D and `GaussianSamplePath2D()` for 2D. We want to approximate 1D process with a scenario tree as follows:

```julia
julia> using ScenTrees
julia> gstree = TreeApproximation!(Tree([1,2,2,2],1),GaussianSamplePath1D,100000,2,2);
julia> treeplot(gstree)
```
![Scenario Tree](docs/src/assets/gstree.pdf)

2. We want to approximate running maximum process with a scenario lattice. It follows the same procedure as for scenario trees only that we use a different function as follows:

```julia
julia> using ScenTrees
julia> rmlattice = LatticeApproximation([1,2,3,4],RunningMaximum1D,100000);
julia> PlotLattice(rmlattice)
```
![Scenario Lattice](docs/src/assets/rmlattice.pdf)

3. We also provide the conditional density estimation of trajectories given a data. Given an $N\timesT$ dataframe, we use the `KernelScenarios()` function to generate a new and similar trajectory with length equal to $T$. This function can thus be used to generated trajectories for creating a scenario tree and a scenario lattice. Consider a Gaussian random walk data which can be generated by calling the function `GaussianSamplePath1D()` many times and saving the result in a matrix form. We can use this data and the kernel density estimation method to generate new and similar trajectories as follows:
```julia
julia> using ScenTrees
julia> gsdata = Array{Float64}(undef,1000,4)
julia> for i = 1:1000
           gsdata[i,:] = GaussianSamplePath1D()
       end
julia> gsGen = KernelScenarios(gsdata,Logistic; Markovian = true)()
4-element Array{Float64,1}:
 6.3183e-16
-1.8681
-3.7719
-3.5241
```
To use the above samples for scenario trees or scenario lattice generation:
```julia
julia> kerneltree = TreeApproximation!(Tree([1,2,2,2],1),KernelScenarios(gsdata,Logistic;Markovian=false),100000,2,2);
julia> treeplot(kerneltree)
julia> kernelLattice = LatticeApproximation([1,3,4,5],KernelScenarios(gsdata,Logistic;Markovian=true),100000);
julia> PlotLattice(kernelLattice)
```

| [![Kernel Tree](docs/src/assets/kerneltree.pdf)](docs/src/assets/kerneltree.pdf)  | [![Kernel Lattice](docs/src/assets/kernelLattice.pdf)](docs/src/assets/kernelLattice.pdf) |
|:---:|:---:|
|Kernel Scenario Tree | Kernel Scenario Lattice  |

## Contributing to ScenTrees.jl

If you believe that you have found any bugs or if you need help or any questions regarding the library and any suggestions, please feel free to file a new Github issue at [New issue](https://github.com/kirui93/ScenTrees.jl/issues/new). You can also raise an issue and issue a pull request which fixes the issue as long as it doesn't affect the performance of this library.

## References

+ Pflug, Georg Ch., and Alois Pichler, 2012. *A distance for Multistage Stochastic Optimization Models*. SIAM Journal on Optimization 22(1) Doi: https://doi.org/10.1137/110825054

+ Pflug, Georg Ch., and Alois Pichler,2015. *Dynamic Generation of Scenario Trees*. Computational Optimizatio and Applications 62(3): Doi: https://doi.org/10.1007/s10589-015-9758-0

+ Pflug, Georg Ch., and Alois Pichler,2016. *From Empirical Observations to Tree Models for Stochastic Optimization : Convergence Properties : Convergence of the Smoothed Empirical Process in Nested Distnce.* SIAM Journal on Optimization 26(3). Society for Industrial and Applied Mathematics (SIAM). Doi: https://doi.org/10.1137/15M1043376.
