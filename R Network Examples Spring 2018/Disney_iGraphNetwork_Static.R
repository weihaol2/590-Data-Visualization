# CREATING A STATIC NETWORK WITH igraph

# Set your working directory by going to Session > Set Working Directory > Choose Directory... or
setwd("~/R Network Examples Spring 2018")

# Install the "igraph" package and load it
install.packages("igraph")
library(igraph)

# Use this command to find help
?igraph

# Load your data with code, make sure to specify the path or set your working directory (Session > set working directory > to files pane location)
nodes <- read.csv("DisneyRidesYear_Nodes.csv", header=T, as.is=T)
edges <- read.csv("DisneyRidesYear_Edges.csv", header=T, as.is=T)

# View and check data class, we want data frames
View(nodes)
class(nodes)
View(edges)
class(edges)

# Create the igraph object
disnet <- graph_from_data_frame(d=edges, vertices=nodes, directed=F)

# Remove self-loops
disnet <- simplify(disnet, remove.loops = T)

# The network is plotted a lot in this demo to show the changes as we make them
plot(disnet)

# Check network info
disnet

# Remove labels
V(disnet)$label <- NA
plot(disnet)

# Add labels
V(disnet)$label=paste(nodes$id,nodes$type.label,sep=', ')
plot(disnet)

# Change label color
V(disnet)$label.color <- "black"
plot(disnet)

# Change label size
V(disnet)$label.cex <- 0.7
plot(disnet)

# Change node size
V(disnet)$size <- 10
plot(disnet)

# Check how many id.types you have
unique(nodes$id.type)

# Use an R graphics palette, type ?rainbow to see the other color palettes in the help, or specify each color with quotes
colrs <- sample(rainbow(16))

# See the hexcodes for colrs
colrs

# Add colors to the nodes
V(disnet)$color <- colrs[V(disnet)$id.type]
plot(disnet)

# Change edge color, edge curved amount, layout, add title
plot(disnet, edge.color="black", edge.curved=0, layout=layout.circle, main="Rides in Magic Kingdom")
plot(disnet, edge.color="black", edge.curved=0, layout=layout.grid)
plot(disnet, edge.color="black", edge.curved=0, layout=layout.reingold.tilford)

# To save the image, you can click Export > Save as image or use:
png(filename="RidesInMagicKingdom.png")
plot(disnet, edge.color="black", edge.curved=0, layout=layout.reingold.tilford)
dev.off()

# Clear your console with ctrl + L
