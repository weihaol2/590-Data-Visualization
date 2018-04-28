# CREATING AN INTERACTIVE NETWORK WITH visNetwork

# Install the "visNetwork" package and load it
install.packages("visNetwork")
library(visNetwork)

# Load your data, specify the path, save as data frames
nodes2 <- read.csv("pokemon_nodes.csv", header=T, as.is=T)
edges2 <- read.csv("pokemon_edges.csv", header=T, as.is=T)

# View the data and check the class of the data
View(nodes2)
class(nodes2)
View(edges2)
class(edges2)

# Preview our raw network and click it
visNetwork(nodes2, edges2)

# Check how many id.types you have
unique(nodes2$id.type)

# Save the colors to a variable, order listed is the order they color the id.types of the nodes
clrs <- c("black","green", "red", "blue", "burlywood", "grey", "purple", "yellow", "brown", "pink", "gold", "plum")

# Assign the colors to the nodes color attribute
nodes2$color <- clrs[nodes2$id.type]

# Create groups for selection options later, order listed is the order they show up in the selection
grps <- c("Pokemon", "Grass", "Fire", "Water", "Bug", "Normal", "Poison", "Electric", "Ground", "Fairy", "Flying", "Dragon")

# Assign the groups to the nodes group attribute
nodes2$group <- grps[nodes2$id.type]

# Change thickness of node border
nodes2$borderWidth <- 2

# Add background shadow to nodes
nodes2$shadow <- TRUE

# Remove labels
nodes2$label <- NA

# Customize the hover text
nodes2 <- data.frame(nodes2, title = paste0("<p><b>",nodes2$id,"</b></p>"))

# Change edge color
edges2$color <- "black"

# Change edge color on highlight
edges2$color.highlight <- "snow4"

# View the changed nodes2 data frame
View(nodes2)

# Finish the network: add titles, groups, and physics
pokenet <- visNetwork(nodes2, edges2, main="Pokemon Types Network", submain = "By Jarai") %>%
  visOptions(selectedBy = "group", highlightNearest = TRUE) %>%
  visGroups(groupname = "Pokemon", color = "black") %>%
  visGroups(groupname = "Grass", color = "green") %>%
  visGroups(groupname = "Fire", color = "red") %>%
  visGroups(groupname = "Water", color = "blue") %>%
  visGroups(groupname = "Bug", color = "burlywood") %>%
  visGroups(groupname = "Normal", color = "grey") %>%
  visGroups(groupname = "Poison", color = "purple") %>%
  visGroups(groupname = "Electric", color = "yellow") %>%
  visGroups(groupname = "Ground", color = "brown") %>%
  visGroups(groupname = "Fairy", color = "pink") %>%
  visGroups(groupname = "Flying", color = "gold") %>%
  visGroups(groupname = "Dragon", color = "plum") %>%
  visInteraction(navigationButtons = TRUE) %>%
  visPhysics(solver = "forceAtlas2Based", 
           forceAtlas2Based = list(gravitationalConstant = -200))

# View the interactive network
pokenet

# Export the network to an html document, use code or: Export > Save as Web Page...
# Somewhat slow to view inside RStudio
visSave(pokenet, file="pokenet.html")

# Change the physics by looking at the help
?visPhysics
