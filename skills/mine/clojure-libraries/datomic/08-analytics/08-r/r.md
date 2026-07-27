<a id="content"></a>

<a id="using-r"></a>

# Using R

[R](https://www.r-project.org/) is a statistical computing environment that is commonly used for data analysis, visualization, and model development. You can access Datomic from R using the [RPresto](https://github.com/prestodb/RPresto) library.

<a id="outline-container-installing"></a>

<a id="installing"></a>

## Installing

<a id="text-installing"></a>

- Install R from [the R CRAN site](https://cran.r-project.org/)
- Install RStudio following the instructions from the [RStudio download page](https://www.rstudio.com/products/rstudio/download/)
- Launch RStudio and install the [RPresto package](https://github.com/prestodb/RPresto)

by running the command below in the R console:

```
install.packages('RPresto')
```

<a id="outline-container-using-rstudio"></a>

<a id="using-rstudio"></a>

## Using RStudio:

<a id="text-using-rstudio"></a>

To connect to Datomic Analytics, follow the configuration shown below and replace the appropriate values for `user`, `host`, `port`, `schema`, and `catalog`:

```
library('DBI')

con <- dbConnect(
  RPresto::Presto(),
  host='http://<host>',
  port=<port>,
  user='<user>',
  schema='<schema>',
  catalog='<catalog>'
)

res <- dbSendQuery(con, 'SELECT * FROM system.runtime.nodes;')
df <- dbFetch(res, -1)
```
