\name{write.graph}
\alias{write.graph}
\title{Writing the graph to a file in some format}
\description{\code{write.graph} is a general function for exporting
  graphs to foreign file formats, however not many formats are
  implemented right now.}
\usage{
write.graph(graph, file, format=c("edgelist", "pajek", "ncol",
       "lgl", "graphml", "dimacs", "gml", "dot", "leda"), \dots)
}
\arguments{
  \item{graph}{The graph to export.}
  \item{file}{A connection or a string giving the file name to write the
    graph to.}
  \item{format}{Character string giving the file format. Right now 
    \code{pajek}, \code{graphml}, \code{dot},
    \code{gml}, \code{edgelist}, \code{lgl},
    \code{ncol} and \code{dimacs} are implemented. As of igraph 0.4 this
    argument is case insensitive.
  }
  \item{\dots}{Other, format specific arguments, see below.}
}
\section{Edge list format}{
  The \code{edgelist} format is a simple text file, with one edge in a
  line, the two vertex ids separated by a space character. The file is
  sorted by the first and the second column. This format has no
  additional arguments.
}
\section{Pajek format}{
  The Pajek format is a text file, see \code{\link{read.graph}} for
  details. Appropriate vertex and edge attributes are also written to
  the file. This format has no additional arguments.

  From version 0.6.1 igraph handles bipartite graphs when writing to
  Pajek files. As Pajek is less flexible for bipartite graphs (the
  numeric ids of the vertices must be sorted according to vertex type),
  igraph might need to reorder the vertices when writing a bipartite
  Pajek file. This effectively means that numeric vertex ids usually
  change when a bipartite graph is written to a Pajek file, and then
  read back into igraph.
}
\section{GraphML format}{
  The GraphML format is a flexible XML based format. See
  \code{\link{read.graph}} for GraphML details. Vertex and edge
  attributes are also written to the file. Additional argument:
  \describe{
    \item{prefixAttr}{Logical scalar, whether you want to add a prefix
      to the graph, vertex and edge attribute names, to ensure their
      uniqueness. Defaults to \code{TRUE}.}
  }
}
\section{Dot format}{
  The dot format is used by the popular GraphViz program. Vertex and
  edge attributes are written to the file. There are no additional
  arguments for this format.
}
\section{LGL format}{
  The \code{lgl} format is also a simple text file, this is the
  format expected by the 'Large Graph Layout' layout generator software.
  See \link{read.graph} for details.
  Additional arguments:
  \describe{
    \item{names}{If you want to write symbolic vertex names instead of
      vertex ids, supply the name of the vertex attribute containing the
      symbolic names here. By default the \sQuote{name} attribute is
      used if there is one. Supply \code{NULL} if you want to use numeric 
      vertex ids even if there is a \sQuote{name} vertex attribute.} 
    \item{weights}{If you want to write edge weights to the file, supply
      the name of the edge attribute here. By defaults the vertex
      attribute \sQuote{weights} are used if they are installed.
      Supply \code{NULL} here if you want to omit the weights.}
    \item{isolates}{Logical, if \code{TRUE} the isolate vertices are
      also written to the file, they are omitted by default.}
  }
}
\section{NCOL format}{
  The \code{ncol} format is also used by LGL, it is a text file, see
  \link{read.graph} for details.
  Additional arguments:
  \describe{
    \item{names}{If you want to write symbolic vertex names instead of
      vertex ids, supply the name of the vertex attribute containing the
      symbolic names here. By default the \sQuote{name} attribute is
      used if there is one. Supply \code{NULL} if you want to use numeric 
      vertex ids even if there is a \sQuote{name} vertex attribute.} 
    \item{weights}{If you want to write edge weights to the file, supply
      the name of the edge attribute here. By defaults the vertex
      attribute \sQuote{weights} are used if they are installed.
      Supply \code{NULL} here if you want to omit the weights.}
  }
}
\section{Dimacs format}{
  The \code{dimacs} file format, more specifically the 
  version for network flow problems, see the files at
  \url{ftp://dimacs.rutgers.edu/pub/netflow/general-info/}
  
  This is a line-oriented text file (ASCII) format. The first
  character of each line defines the type of the line. If the first
  character is \code{c} the line is a comment line and it is
  ignored. There is one problem line (\code{p} in the file, it
  must appear before any node and arc descriptor lines. The problem
  line has three fields separated by spaces: the problem type
  (\code{min}, \code{max} or \code{asn}), the
  number of vertices and number of edges in the graph.
  Exactly two node identification lines are expected
  (\code{n}), one for the source, one for the target vertex.
  These have two fields: the id of the vertex and the type of the
  vertex, either \code{s} (=source) or \code{t}
  (=target). Arc lines start with \code{a} and have three
  fields: the source vertex, the target vertex and the edge capacity.
  
  Vertex ids are numbered from 1.
  
  Additional arguments:
  \describe{
    \item{source}{The id of the source vertex, if \code{NULL} (the
      default) then it is taken from the \code{source} graph attribute.}
    \item{target}{The id of the target vertex, if \code{NULL} (the
      default) then it is taken from the \code{target} graph attribute.}
    \item{capacity}{A numeric vector giving the edge capacities. If
      \code{NULL} (the default) then it is taken from the
      \code{capacity} edge attribute.}
  }
}
\section{GML file format}{
  GML is a quite general textual format, see 
  \url{http://www.infosun.fim.uni-passau.de/Graphlet/GML/} for details.
 
  The graph, vertex and edges attributes are written to the
  file as well, if they are numeric of string.
 
  As igraph is more forgiving about attribute names, it might 
  be neccessary to simplify the them before writing to the GML file.
  This way we'll have a syntactically correct GML file. The following 
  simple procedure is performed on each attribute name: first the alphanumeric 
  characters are extracted, the others are ignored. Then if the first character
  is not a letter then the attribute name is prefixed with <quote>igraph</quote>.
  Note that this might result identical names for two attributes, igraph 
  does not check this. 
 
  The \dQuote{id} vertex attribute is treated specially. 
  If the \code{id} argument is not \code{NULL} then it should be a numeric 
  vector with the vertex ids and the \dQuote{id} vertex attribute is 
  ignored (if there is one). If \code{id} is 0 and there is a 
  numeric \code{id} vertex attribute that is used instead. If ids
  are not specified in either way then the regular igraph vertex ids are used.
 
  Note that whichever way vertex ids are specified, their 
  uniqueness is not checked.
 
  If the graph has edge attributes named \dQuote{source}
  or \dQuote{target} they're silently ignored. GML uses these attributes
  to specify the edges, so we cannot write them to the file. Rename them 
  before calling this function if you want to preserve them.

  Additional arguments:
  \describe{
    \item{id}{\code{NULL} or a numeric vector giving the vertex ids. See
      details above.}
    \item{creator}{A character scalar to be added to the
      \dQuote{Creator} line in the GML file. If this is \code{NULL} (the
      default) then the current date and time is added.}
  }
}
\section{LEDA file format}{
  LEDA is a library for efficient data types and algorithms. 
  The support for the LEDA format is very basic at the moment; igraph
  writes only the LEDA graph section which supports one selected vertex
  and edge attribute and no layout information or visual attributes.
  See
  \url{http://www.algorithmic-solutions.info/leda_guide/graphs/leda_native_graph_fileformat.html}
  for the details of this format.

  Additional arguments:
  \describe{
    \item{vertex.attr}{The name of the vertex attribute whose values
      are to be stored in the output or \code{NULL} if no vertex
      attribute has to be stored.} 
    \item{edge.attr}{The name of the edge attribute whose values
      are to be stored in the output or \code{NULL} if no edge attribute
      has to be stored.}
  }
}
\value{A NULL, invisibly.}
\references{Adai AT, Date SV, Wieland S, Marcotte EM. LGL: creating a
  map of protein function with an algorithm for visualizing very large
  biological networks. \emph{J Mol Biol.} 2004 Jun 25;340(1):179-90.}
\author{Gabor Csardi \email{csardi.gabor@gmail.com}}
\seealso{ \code{\link{read.graph}} }
\examples{
g <- graph.ring(10)
\dontrun{write.graph(g, "/tmp/g.txt", "edgelist")}
}
\keyword{graphs}
