\name{graph-isomorphism}
\alias{graph.isoclass}
\alias{graph.isocreate}
\alias{graph.isomorphic}
\alias{graph.isomorphic.vf2}
\alias{graph.count.isomorphisms.vf2}
\alias{graph.count.subisomorphisms.vf2}
\alias{graph.get.isomorphisms.vf2}
\alias{graph.get.subisomorphisms.vf2}
\alias{graph.isoclass.subgraph}
\alias{graph.isomorphic.34}
\alias{graph.isomorphic.bliss}
\alias{graph.subisomorphic.vf2}
\alias{graph.subisomorphic.lad}
\concept{Graph isomorphism}
\concept{Subgraph isomorphism}
\concept{VF2 algorithm}
\concept{BLISS algorithm}
\title{Graph Isomorphism}
\description{These functions deal with graph isomorphism.}
\usage{
graph.isomorphic(graph1, graph2)
graph.isomorphic.34(graph1, graph2)
graph.isomorphic.bliss(graph1, graph2, sh1="fm", sh2="fm")
graph.isomorphic.vf2(graph1, graph2, vertex.color1, vertex.color2,
     edge.color1, edge.color2)

graph.count.isomorphisms.vf2(graph1, graph2,
     vertex.color1, vertex.color2,
     edge.color1, edge.color2)
graph.get.isomorphisms.vf2(graph1, graph2,
     vertex.color1, vertex.color2,
     edge.color1, edge.color2)

graph.subisomorphic.vf2(graph1, graph2,
     vertex.color1, vertex.color2,
     edge.color1, edge.color2)
graph.count.subisomorphisms.vf2(graph1, graph2,
     vertex.color1, vertex.color2,
     edge.color1, edge.color2)
graph.get.subisomorphisms.vf2(graph1, graph2,
     vertex.color1, vertex.color2,
     edge.color1, edge.color2)

graph.subisomorphic.lad (pattern, target, domains = NULL, 
                         induced = FALSE, map = TRUE, all.maps = FALSE,
                         time.limit = Inf)

graph.isoclass(graph)
graph.isoclass.subgraph(graph, vids)
graph.isocreate(size, number, directed=TRUE)
}
\arguments{
  \item{graph}{A graph object.}
  \item{graph1,graph2}{Graph objects}
  \item{vertex.color1,vertex.color2}{
    Optional integer vectors giving the colors of the
    vertices for colored (sub)graph isomorphism. If they are not given,
    but the graph has a \dQuote{color} vertex attribute, then it will be
    used. If you want to ignore these attributes, then supply
    \code{NULL} for both of these arguments. See also examples below.}
  \item{edge.color1,edge.color2}{
    Optional integer vectors giving the colors of the edges
    for edge-colored (sub)graph isomorphism. If they are not given,
    but the graph has a \dQuote{color} edge attribute, then it will be
    used. If you want to ignore these attributes, then supply
    \code{NULL} for both of these arguments.}
  \item{size}{A numeric integer giving the number of vertices in the
    graph to create. Only three or four are suppported right now.}
  \item{number}{The number of the isomorphism class of the graph to be
    created.}
  \item{directed}{Whether to create a directed graph.}
  \item{sh1}{Character constant, the heuristics to use in the BLISS
    algorithm, for \code{graph1}. See the \code{sh} argument of
    \code{\link{canonical.permutation}} for possible values.}
  \item{sh2}{Character constant, the heuristics to use in the BLISS
    algorithm, for \code{graph2}. See the \code{sh} argument of
    \code{\link{canonical.permutation}} for possible values.}
  \item{vids}{Numeric vector, the vertex ids of vertices to form the
    induced subgraph for determining the isomorphism class.}
  \item{pattern}{The smaller graph, it might be directed or
    undirected. Undirected graphs are treated as directed graphs with
    mutual edges.}
  \item{target}{The bigger graph, it might be directed or
    undirected. Undirected graphs are treated as directed graphs with
    mutual edges.}
  \item{domains}{If not \code{NULL}, then it specifies matching
    restrictions. It must be a list of \code{target} vertex sets, given
    as numeric vertex ids or symbolic vertex names. The length of the
    list must be \code{vcount(pattern)} and for each vertex in
    \code{pattern} it gives the allowed matching vertices in
    \code{target}.}
  \item{induced}{Logical scalar, whether to search for an induced
    subgraph. It is \code{FALSE} by default.}
  \item{map}{Logical scalar, whether to return a mapping between
    \code{pattern} and \code{target}. Defaults to \code{TRUE}.}
  \item{all.maps}{Logical scalar, whether to return all mappings between
    \code{pattern} and \code{target}. Defaults to \code{FALSE}.}
  \item{time.limit}{The processor time limit for the computation, in
    seconds. It defaults to \code{Inf}, which means no limit. }
}
\details{
  \code{graph.isomorphic} decides whether two graphs are isomorphic.
  The input graphs must be both directed or both undirected.
  This function is a higher level interface to the other graph
  isomorphism decision functions. Currently it does the following:
  \enumerate{
    \item If the two graphs do not agree in the number of vertices and
    the number of edges then \code{FALSE} is returned.
    \item Otherwise if the graphs have 3 or 4 vertices, then
    \code{igraph.isomorphic.34} is called.
    \item Otherwise if the graphs are directed, then
    \code{igraph.isomorphic.vf2} is called.
    \item Otherwise \code{igraph.isomorphic.bliss} is called.
  }

  \code{igraph.isomorphic.34} decides whether two graphs, both of which
  contains only 3 or 4 vertices, are isomorphic. It works based on a
  precalculated and stored table.

  \code{igraph.isomorphic.bliss} uses the BLISS algorithm by Junttila
  and Kaski, and it works for undirected graphs. For both graphs the
  \code{\link{canonical.permutation}} and then the
  \code{\link{permute.vertices}} function is called to transfer them
  into canonical form; finally the canonical forms are compared.

  \code{graph.isomorphic.vf2} decides whethe two graphs are isomorphic,
  it implements the VF2 algorithm, by Cordella, Foggia et al., see
  references.

  \code{graph.count.isomorphisms.vf2} counts the different isomorphic
  mappings between \code{graph1} and \code{graph2}. (To count
  automorphisms you can supply the same graph twice, but it is better to
  call \code{\link{graph.automorphisms}}.) It uses the VF2 algorithm.

  \code{graph.get.isomorphisms.vf2} calculates all isomorphic mappings
  between \code{graph1} and \code{graph2}. It uses the VF2 algorithm.

  \code{graph.subisomorphic.vf2} decides whether \code{graph2} is
  isomorphic to some subgraph of \code{graph1}. It uses the VF2 algorithm.

  \code{graph.count.subisomorphisms.vf2} counts the different isomorphic
  mappings between \code{graph2} and the subgraphs of \code{graph1}. It
  uses the VF2 algorithm.

  \code{graph.get.subisomorphisms.vf2} calculates all isomorphic
  mappings between \code{graph2} and the subgraphs of \code{graph1}. It
  uses the VF2 algorithm.

  \code{graph.subisomorphic.lad} checks whether \code{pattern} is
  isomorphic to a subgraph or induced subgraph of \code{target}. It can
  also optionally return a mapping, or all possible mappings between the
  two graphs. Its \code{domains} argument allows for a flexible way to
  restrict the matching to a subset of allowed vertices, individually
  for each vertex in \code{pattern}.
  
  \code{graph.isoclass} returns the isomorphism class of a graph, a
  non-negative integer number. Graphs (with the same number of vertices)
  having the same isomorphism class are isomorphic and isomorphic graphs
  always have the same isomorphism class. Currently it can handle only
  graphs with 3 or 4 vertices.

  \code{graph.isoclass.subgraph} calculates the isomorphism class of a
  subgraph of the input graph. Currently it only works for subgraphs
  with 3 or 4 vertices.
  
  \code{graph.isocreate} create a graph from the given isomorphic
  class. Currently it can handle only graphs with 3 or 4 vertices.
}
\note{
  Functions \code{graph.isoclass}, \code{graph.isoclass.subgraph} and
  \code{graph.isocreate} are considered experimental and might be
  reorganized/rewritten later.
}
\value{
  \code{graph.isomorphic} and \code{graph.isomorphic.34} return a
  logical scalar, \code{TRUE} if the input graphs are isomorphic,
  \code{FALSE} otherwise.

  \code{graph.isomorphic.bliss} returns a named list with elements:
  \item{iso}{A logical scalar, whether the two graphs are isomorphic.}
  \item{map12}{A numeric vector, an mapping from \code{graph1} to
    \code{graph2} if \code{iso} is \code{TRUE}, an empty numeric
    vector otherwise.}
  \item{map21}{A numeric vector, an mapping from \code{graph2} to
    \code{graph1} if \code{iso} is \code{TRUE}, an empty numeric
    vector otherwise.}
  \item{info1}{Some information about the canonical form calculation
    for \code{graph1}. A named list, see the return value of
    \code{\link{canonical.permutation}} for details. Note that if the
		two graphs have different number of vertices or edges, then the
		BLISS algorithm is not run at all, and the contents of \code{info1}
		is incorrect.}
  \item{info2}{Some information about the canonical form calculation
    for \code{graph2}. A named list, see the return value of
    \code{\link{canonical.permutation}} for details. Note that if the
		two graphs have different number of vertices or edges, then the
		BLISS algorithm is not run at all, and the contents of \code{info2}
		is incorrect.}

  \code{graph.isomorphic.vf2} returns a names list with three elements:
  \item{iso}{A logical scalar, whether the two graphs are isomorphic.}
  \item{map12}{A numeric vector, an mapping from \code{graph1} to
    \code{graph2} if \code{iso} is \code{TRUE}, an empty numeric
    vector otherwise.}
  \item{map21}{A numeric vector, an mapping from \code{graph2} to
    \code{graph1} if \code{iso} is \code{TRUE}, an empty numeric
    vector otherwise.}

  \code{graph.count.isomorphisms.vf2} returns a numeric scalar, an
  integer, the number of isomorphic mappings between the two input
  graphs.

  \code{graph.get.isomorphisms.vf2} returns a list of numeric
  vectors. Every numeric vector is a permutation which takes
  \code{graph2} into \code{graph1}.

  \code{graph.subisomorphic.vf2} returns a named list with three
  elements:
  \item{iso}{Logical scalar, \code{TRUE} if a subgraph of
    \code{graph1} is isomorphic to \code{graph2}.}
  \item{map12}{Numeric vector, empty if \code{iso} is
    \code{FALSE}. Otherwise a mapping from a subgraph of \code{graph1}
    to \code{graph2}. -1 denotes the vertices which are not part of
    the mapping.}
  \item{map21}{Numeric vector, empty if \code{iso} is
    \code{FALSE}. Otherwise a mapping from \code{graph2} into
    \code{graph1}.}

  \code{graph.count.subisomorphisms.vf2} returns a numeric scalar, an
  integer.

  \code{graph.get.subisomorphisms.vf2} returns a list of numeric
  vectors, each numeric vector is an isomorphic mapping from
  \code{graph2} to a subgraph of \code{graph1}.

  \code{graph.subisomorphic.lad} return a named list with three entries:
  \item{iso}{Logical scalar, whether the algorithm found a subgraph (or
    induced subgraph is the \code{induced} argument in \code{TRUE}) in
    \code{target} that is isomorphic to \code{pattern}.}
  \item{map}{If a mapping is requested via the \code{map} argument, then
    a numeric vector of vertex ids from \code{target}, the matching
    vertices for each \code{pattern} vertex in \code{pattern} vertex id
    order. Otherwise \code{NULL}.}
  \item{maps}{If all mappings are requested via the \code{all.maps}
    argument, then all possible mappings from \code{pattern} to
    \code{target}, in a list of vectors, where each vector is in the
    same format as \code{map} just above.}
  
  \code{graph.isoclass} and \code{graph.isoclass.subgraph} return a
  non-negative integer number. 

  \code{graph.isocreate} returns a graph object.
}
\references{
  Tommi Junttila and Petteri Kaski: Engineering an Efficient Canonical
  Labeling Tool for Large and Sparse Graphs, \emph{Proceedings of the
    Ninth Workshop on Algorithm Engineering and Experiments and the
    Fourth Workshop on Analytic Algorithms and Combinatorics.} 2007.

  LP Cordella,  P Foggia, C Sansone, and M Vento:
  An improved algorithm for matching large graphs,
  \emph{Proc. of the 3rd IAPR TC-15 Workshop on Graphbased
    Representations in Pattern Recognition}, 149--159, 2001.

  C. Solnon: AllDifferent-based Filtering for Subgraph Isomorphism,
  \emph{Artificial Intelligence} 174(12-13):850--864, 2010.
}
\author{ Gabor Csardi \email{csardi.gabor@gmail.com}}
\seealso{\code{\link{graph.motifs}}}
\examples{
# create some non-isomorphic graphs
g1 <- graph.isocreate(3, 10)
g2 <- graph.isocreate(3, 11)
graph.isoclass(g1)
graph.isoclass(g2)
graph.isomorphic(g1, g2)

# create two isomorphic graphs, by
# permuting the vertices of the first 
g1 <- barabasi.game(30, m=2, directed=FALSE)
g2 <- permute.vertices(g1, sample(vcount(g1)))
# should be TRUE
graph.isomorphic(g1, g2)
graph.isomorphic.bliss(g1, g2)
graph.isomorphic.vf2(g1, g2)

# colored graph isomorphism
g1 <- graph.ring(10)
g2 <- graph.ring(10)
graph.isomorphic.vf2(g1, g2)

V(g1)$color <- rep(1:2, length=vcount(g1))
V(g2)$color <- rep(2:1, length=vcount(g2))
graph.count.isomorphisms.vf2(g1, g2)
graph.count.isomorphisms.vf2(g1, g2, vertex.color1=NULL,
    vertex.color2=NULL)

V(g1)$name <- letters[1:vcount(g1)]
V(g2)$name <- LETTERS[1:vcount(g2)]
graph.get.isomorphisms.vf2(g1, g2)

V(g1)$color <- 1
V(g2)$color <- 2
graph.isomorphic.vf2(g1, g2)
graph.isomorphic.vf2(g2, g2, vertex.color1=NULL,
    vertex.color2=NULL)

# The LAD example
pattern <- graph.formula(1:2:3:4:5,
                         1 - 2:5, 2 - 1:5:3, 3 - 2:4, 4 - 3:5, 5 - 4:2:1)
target <- graph.formula(1:2:3:4:5:6:7:8:9,
                        1 - 2:5:7, 2 - 1:5:3, 3 - 2:4, 4 - 3:5:6:8:9,
                        5 - 1:2:4:6:7, 6 - 7:5:4:9, 7 - 1:5:6,
                        8 - 4:9, 9 - 6:4:8)
domains <- list(`1` = c(1,3,9), `2` = c(5,6,7,8), `3` = c(2,4,6,7,8,9),
                `4` = c(1,3,9), `5` = c(2,4,8,9))
graph.subisomorphic.lad(pattern, target, all.maps=TRUE)
graph.subisomorphic.lad(pattern, target, induced=TRUE, all.maps=TRUE)
graph.subisomorphic.lad(pattern, target, domains=domains, all.maps=TRUE)

# Directed LAD example
pattern <- graph.formula(1:2:3, 1 -+ 2:3)
uring <- graph.ring(10)
dring <- graph.ring(10, directed=TRUE)
graph.subisomorphic.lad(pattern, uring)
graph.subisomorphic.lad(pattern, dring)
}
\keyword{graphs}
