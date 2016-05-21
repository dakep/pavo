#' Plot spectra in a colourspace
#'
#' \code{plot.colspace} Plots reflectance spectra in the appropriate colorspace
#' 
#' @param clrspdata (required) an object of class \code{colspace}. 
#' @param ... additional graphical options, which vary by modelled \code{space}. Refer 
#'  to their individual help files: 
#'  \itemize{ 
#'        \item \code{\link{diplot}}: dichromat space
#'        \item \code{\link{triplot}}: trichromat space
#'        \item \code{\link{tcsplot}}: tetrahedral space
#'        \item \code{\link{catplot}}: categorical space 
#'        \item \code{\link{hexplot}}: colour hexagon
#'        \item \code{\link{cocplot}}: colour-opponent-coding space
#'        \item \code{\link{cieplot}}: cie spaces
#'        }
#'        Also see \code{\link{par}}. 
#' 
#' @return \itemize{ 
#'          \item \code{plot.colspace} creates a 2D colspace plot appropriate to the input data.
#'          \item \code{points.colspace} adds points to the plot. When \code{space = 'tcs'}, 
#'            it creates an interactive 3D plot using functions of the package \code{rgl}, 
#'            based on openGL capabilities. It can be manipulated with the mouse 
#'            (left button: rotate along z' axis; right button: rotate along 'x' 
#'            axis; third button: zoom). 
#'          \item \code{vol.colspace} produces a 3D convex hull in tetrahedral colorspace 
#'            (i.e. when \code{space = 'tcs'}).
#'            }
#' 
#' @examples \dontrun{
#' data(flowers)
#' 
#' # Dichromat
#' vis.flowers <- vismodel(flowers, visual = 'canis')
#' di.flowers <- colspace(vis.flowers, space = 'di')
#' plot(di.flowers)
#'
#' # Colour hexagon 
#' vis.flowers <- vismodel(flowers, visual = 'apis', qcatch = 'Ei', relative = FALSE, vonkries = TRUE, achro = 'l', bkg = 'green')
#' hex.flowers <- colspace(vis.flowers, space = 'hexagon')
#' plot(hex.flowers, sectors = 'coarse')
#' 
#' # Tetrahedron
#' data(sicalis)
#' vis.sicalis <- vismodel(sicalis, visual = 'avg.uv')
#' tcs.sicalis <- colspace(vis.sicalis, space = 'tcs')
#' plot(tcs.sicalis, size = 0.005)
#' rgl.postscript('testplot.pdf',fmt = 'pdf') 
#' rgl.snapshot('testplot.png')
#'
#' ## Add points to tetrahedron
#' patch <- rep(c('C','T','B'), 7)
#' tcs.crown <- subset(tcs.sicalis, 'C')
#' tcs.breast <- subset(tcs.sicalis, 'B') 
#' plot(tcs.crown, col ='blue')
#' points(tcs.breast, col ='red')
#'
#' ## Plot convex hull in tetrahedron
#' plot(tcs.sicalis, col = 'blue', size = 0.005)
#' vol(tcs.sicalis)
#' }
#' 
#' @seealso \code{\link{plot}}
#' 
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @author Thomas White \email{thomas.white026@@gmail.com}
#'  
#' @export
#'  
#' @references Smith T, Guild J. (1932) The CIE colorimetric standards and their use.
#'    Transactions of the Optical Society, 33(3), 73-134.
#' @references Westland S, Ripamonti C, Cheung V. (2012). Computational colour science 
#'    using MATLAB. John Wiley & Sons.
#' @references Chittka L. (1992). The colour hexagon: a chromaticity diagram
#'    based on photoreceptor excitations as a generalized representation of 
#'    colour opponency. Journal of Comparative Physiology A, 170(5), 533-543.
#' @references Chittka L, Shmida A, Troje N, Menzel R. (1994). Ultraviolet as a 
#'    component of flower reflections, and the colour perception of Hymenoptera. 
#'    Vision research, 34(11), 1489-1508.
#' @references Troje N. (1993). Spectral categories in the learning behaviour
#'  of blowflies. Zeitschrift fur Naturforschung C, 48, 96-96.
#' @references Stoddard, M. C., & Prum, R. O. (2008). Evolution of avian plumage 
#'  color in a tetrahedral color space: A phylogenetic analysis of new world buntings. 
#'  The American Naturalist, 171(6), 755-776.
#' @references Endler, J. A., & Mielke, P. (2005). Comparing entire colour patterns 
#'  as birds see them. Biological Journal Of The Linnean Society, 86(4), 405-431.
#' @references Kelber A, Vorobyev M, Osorio D. (2003). Animal colour vision
#'    - behavioural tests and physiological concepts. Biological Reviews, 78,
#'    81 - 118.
#' @references Backhaus W. (1991). Color opponent coding in the visual system
#'  of the honeybee. Vision Research, 31, 1381-1397.

plot.colspace <- function(clrspdata, ...){
  
  space <- attr(clrspdata, 'clrsp')
  
  switch(space,
         'dispace' = diplot(clrspdata, ...),
         'trispace' = triplot(clrspdata, ...),
         'hexagon' = hexplot(clrspdata, ...),
         'tcs' = tcsplot(clrspdata, ...),
         'coc' = cocplot(clrspdata, ...),
         'categorical' = catplot(clrspdata, ...),
         'CIEXYZ' = cieplot(clrspdata, ...),
         'CIELAB' = cieplot(clrspdata, ...)
  )
  
}