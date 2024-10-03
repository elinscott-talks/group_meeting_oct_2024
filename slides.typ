#import "@preview/polylux:0.3.1": *
#import "@preview/touying:0.4.2": *
#import "@preview/pinit:0.1.4": *
#import "@preview/xarrow:0.3.0": xarrow
#import "@preview/cetz:0.2.2"
#import "@preview/suiji:0.3.0": *
#import "psislides.typ"

// color-scheme can be navy-red, blue-green, or pink-yellow
#let s = psislides.register(aspect-ratio: "16-9", color-scheme: "pink-yellow")

#let s = (s.methods.info)(
  self: s,
  title: [Are our corrections correct?],
  subtitle: [A provocative chat among friends],
  author: [Edward Linscott],
  date: datetime(year: 2024, month: 10, day: 3),
  location: [THEOS Group Meeting],
  references: [references.bib],
)
#let blcite(reference) = {
  text(fill: white, cite(reference))
}

#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))

#set footnote.entry(clearance: 0em)
#show bibliography: set text(0.6em)


#let (init, slides) = utils.methods(s)
#show: init

#let (slide, empty-slide, title-slide, new-section-slide, focus-slide, matrix-slide) = utils.slides(s)
#show: slides

#matrix-slide(title: "Our starting point: piecewise linearity")[
  #image("figures/cococcioni_pwl.png", height: 80%)
][
  #pause
  This idea of piecewise linearity is central to a lot of what we do
  
  #pause
  - DFT+#emph[U] (and its +#emph[V] and +#emph[J] extensions)#pause
  - Koopmans functionals #pause
  - dynamical functionals #pause
  - ...


]

== Exact conditions
*PWL*
$ (d^2 E)/(d N^2) = 0 $

*Generalised PWL*
$ Delta E_i = epsilon_i arrow.l.double.long (d^2 E) / (d f_i^2) = 0 $

= DFT+#emph[U]

#grid(align: horizon, columns: (1fr, 1fr), column-gutter: 10pt,
  $ E_U = & sum_(I m m' sigma) U^I/2 n_(m m')(delta_(m' m) - n_(m' m')) \
  = & sum_(I i sigma) U^I/2 lambda_i^(I sigma)(1 - lambda_i^(I sigma)) $,
  $ hat(V)^sigma_U = & sum_(I m m') U^I/2 (delta_(m m') - 2 n^(I sigma)_(m m'))|phi^(I sigma)_m angle.r angle.l phi^(I sigma)_m'| \
  = & sum_(I i) U^I/2 (1 - 2 lambda^(I sigma)_i)|phi_i^(I sigma) angle.r angle.l phi_i^(I sigma)| $
)

#pause

#grid(align: horizon+center, columns: 5, column-gutter: 10pt, row-gutter: 10pt,
  image("figures/phi52_4.png", width: 100%),
  image("figures/phi52_3.png", width: 100%),
  image("figures/phi52_2.png", width: 100%),
  image("figures/phi52_1.png", width: 100%),
  image("figures/phi52_0.png", width: 100%),
  $lambda_1^(I sigma) = 0.99$,
  $lambda_2^(I sigma) = 0.99$,
  $lambda_3^(I sigma) = 0.99$,
  $lambda_4^(I sigma) = 0.36$,
  $lambda_5^(I sigma) = 0.36$
)

== The link between PWL and DFT+#emph[U] is imperfect
#pause
- corrects curvature with respect to $lambda^(I sigma)_i$ --- local, not global curvature ($N$) @Bajaj2017
  #pause
  #v(-10pt) (justified either via...
  - frontier orbital argument; or #pause
  - "strongly interacting subspace" argument #pause
  #v(-10pt) ... neither of which are compelling) #pause
- orbitals are #emph[partially] determined by the user
  #pause
- the recipe for calculating $U$ via linear-response involves charge-conserving perturbations

#slide(title: "An alternative recipe")[
#align(center+horizon)[
#cetz-canvas({
  import cetz.draw: *
  rect((-7, 0), (-3, 4), fill: s.colors.primary, stroke: none)
  circle((-5, 2), radius: 0.7, name: "site 1", fill: white, stroke: none)

  (pause,)
  content((-5, 2), text(fill: black, $bold(+alpha)$))

  (pause,)

  for i in range(7) {
    let angle = i / 7 * 2 * calc.pi
    let rng = gen-rng(42 + i)
    let (rng, jitter) = normal(rng, size: 6, scale: 0.05)
    bezier((0.7 * calc.sin(angle) - 5 + jitter.at(0), 2 + 0.7 * calc.cos(angle) + jitter.at(1)), (1.5 * calc.sin(angle) -5 + jitter.at(2), 2 + 1.5 * calc.cos(angle) + jitter.at(3)), (1.1 * calc.sin(angle) -5 + 2 * jitter.at(4), 2 + 1.1 * calc.cos(angle) + 2 * jitter.at(5)), mark: (end: "stealth"), stroke: 2pt + white)
  }
  (pause,)
  content((-5, -0.5), text($Delta n != 0; Delta N = 0$))

  (pause,)
  line((-2.5, 2), (-0.5, 2), mark: (end: "stealth"), fill: black, stroke: 7pt)

  rect((0, 0), (8, 4), fill: s.colors.primary, stroke: none)
  circle((2, 2), radius: 0.7, fill: white, stroke: none)
  circle((6, 2), radius: 0.7, fill: white, stroke: none)

  (pause,)

  content((2, 2), text(fill: black, $bold(+alpha)$))
  content((6, 2), text(fill: black, $bold(-alpha)$))

  (pause,)
  bezier((2.6, 1.8), (5.2, 1.8), (4.0, 1.4), mark: (end: "stealth"), stroke: 4pt + white)

  (pause,)

  rect((-0.1, -0.1), (4.1, 4.1), stroke: (thickness: 2pt, dash: "dashed"))
  content((2, -0.5), text($Delta n = Delta N$))

})
]
]
= DFT+#emph[U]+#emph[V]
== DFT+#emph[U]+#emph[V]


#slide[
$ E_V = & - sum_(I J)^* V^(I J)/2 sum_(i j sigma) n^(I J sigma)_(i j) n^(J I sigma)_(i j) space space "and" space space hat(V)^sigma_V = & - sum_(I J)^* V^(I J)sum_(i j) n_(j i)^(J I sigma)|phi_i^(I sigma)angle.r angle.l phi^(J sigma)_j| $

//Note now we have $bold(n)^(I J sigma)$ (and $bold(n)^(I sigma) = bold(n)^(I I sigma)$)

#pause
Harder to relate to PWL. For $s$-orbital Hubbard subspaces...

$ (d^2 E_V) / (d n^(I J sigma) d n^(J I sigma)) = V^(I J) $

#pause
_cf._ the $+V$ LR recipe $chi^(I J) = (d n^(I I)) / (d alpha^J)$ which relates to $(d^2 E) / (d n^(I sigma) d n^(J sigma)) = 0$

#pause

But in _some_ cases DFT+#emph[U]+#emph[V] results are better than DFT+#emph[U] -- how can we make sense of this?
]

#slide(title: "Off-diagonal corrections as diagonal corrections")[

We have
$ hat(V)^sigma_U = & sum_(I i) U^I/2 (1 - 2 lambda^(I sigma)_i)|phi_i^(I sigma) angle.r angle.l phi_i^(I sigma)| space space "and" space space hat(V)^sigma_V = & - sum_(I J)^* V^(I J)sum_(i j) n_(j i)^(J I sigma)|phi_i^(I sigma)angle.r angle.l phi^(J sigma)_j| $

#pause
It is simple to prove that
$ hat(V)^sigma_(U) + hat(V)^sigma_V = sum_(I i sigma) (U^I) / 2 (1 - 2 lambda_i) |tilde(phi)^(I sigma)_i angle.r angle.l tilde(phi)^(I sigma)_i| $

#pause
where we have the hybridised orbitals
$ |tilde(phi)_i^(I sigma) angle.r = |phi_i^(I sigma) angle.r + sum_J^* sum_j c^(I J sigma)_(i j) |phi_j^(J sigma) angle.r space space space space space space space space space space space c^(I J sigma)_(i j) = (2 V^(I J) n_(j i)^(J I sigma))/(U^J (1 - 2 lambda^(J sigma)_j) - U^I (1 - 2 lambda^(I sigma)_i)) $

]

== Off-diagonal corrections as diagonal corrections

$ hat(V)^sigma_(U + V) = sum_(I i sigma) (U^I) / 2 (1 - 2 lambda_i) |tilde(phi)^(I sigma)_i angle.r angle.l tilde(phi)^(I sigma)_i| space space space space space space space space space |tilde(phi)_i^(I sigma) angle.r = |phi_i^(I sigma) angle.r + sum_J^* sum_j c_(i j)^(I J sigma)|phi_j^(J sigma) angle.r $

#pause
- DFT+#emph[U]+#emph[V] is equivalent to DFT+#emph[U] using hybridised projectors! #pause
- the degree of hybridisation ($c_(i j)^(I J sigma)$) depends on $U$, $V$, $n^(I J)_(i j)$ #pause
- only valid in $U >> V$ limit, not self-consistent #pause
- PWL applies!

#slide[
#grid(align: horizon+center, columns: 5, column-gutter: 10pt, row-gutter: 10pt,
  image("figures/phi52_4.png", width: 100%),
  image("figures/phi52_3.png", width: 100%),
  image("figures/phi52_2.png", width: 100%),
  image("figures/phi52_1.png", width: 100%),
  image("figures/phi52_0.png", width: 100%),
  image("figures/phi52_4_mod.png", width: 100%),
  image("figures/phi52_3_mod.png", width: 100%),
  image("figures/phi52_2_mod.png", width: 100%),
  image("figures/phi52_1_mod.png", width: 100%),
  image("figures/phi52_0_mod.png", width: 100%),
)
]

#grid(align: horizon, columns: (1fr, 1fr), column-gutter: 10pt,
  image("figures/diag.png", width: 100%),
  image("figures/hybrid.png", width: 100%),
)

== Ramifications for linear response
Suppose we now want to linearise $E$ wrt the occupation of the hybridised orbitals

#pause
$ tilde(chi)^(I J) = (d tilde(n)^(I I)) / (d alpha^J) = chi^(I J) + 2 sum_K^* sum_(i j sigma) c_(i j)^(I K sigma) (d n_(j i)^(K I sigma)) / (d alpha^J) $

#pause
We have terms that don't appear in conventional LR!
// cf. conventional LR $(d^2E) / (d n^(I I sigma) d n^(J J sigma))$: no connection with PWL, #pause leads to unphysical results e.g.
// 
// $ E(n^(1 sigma) &- delta n, n^(2 sigma) + delta n) - E (n^(1 sigma), n^(2 sigma)) \ & = delta n (- (d E) / (d n^(1 sigma)) + (d E) / (d n^(2 sigma))) + 1 / 2 delta n^2 (cancel((d^2 E) / (d (n^(1 sigma))^2)) - 2 cancel((d^2 E) / (d n^(1 sigma) d n^(2 sigma))) + cancel((d^2 E) / (d (n^(2 sigma))^2))) $

== +#emph[V] is equivalent to +#emph[U] with revised projectors


= DFT+#emph[U]+#emph[J]

#grid(align: horizon, column-gutter: 10pt, columns: (3fr, 2fr),[
$E$ should also be piecewise linear as a function of the magnetization@Burgess2023b

DFT typically gives an erroneous concave curvature@Bajaj2017

], image("figures/fig_bajaj_2d_pwl.jpeg", width: 100%)
)


#grid(align: horizon, columns: (3fr, 2fr), [
... but the +#emph[J] functional is not the right shape!

],
    image("figures/j_correction.png", height: 90%))

This served as inspiration for the BLOR functional@Burgess2023a@Burgess2024

#v(-20pt)
#align(center,
  grid(columns: 3, align: horizon+center, inset: 15pt,
    image("figures/novel_u_correction_equal.png", height: 60%),
    image("figures/novel_k_correction.png", height: 60%),
    image("figures/mBLOR.png", height: 50%),
    "correction to SIE", 
    "correction to SCE", 
    "correction to both for a multi-projector subspace")
)

// Add some results for stretched molecules plus their latest work

#align(center,
  grid(columns: 2, align: horizon+center, inset: 15pt,
    image("figures/h2_blor.png", height: 70%),
    image("figures/o2_mblor.png", height: 70%),
    "non-spin-polarized stretched H" + sub("2"), 
    "non-spin-polarized stretched O" + sub("2")
  )
)

= Koopmans functionals

$ E^bold(alpha)_"KI" [{rho_i}]
// = & E_"DFT" [rho] + sum_i [- (E_"DFT" [rho] - E_"DFT" [rho^(f_i arrow.r 0)]) + f_i (E_"DFT" [rho^(f_i arrow.r 1)] - E_"DFT" [rho^(f_i arrow.r 0)])] \
= & E_"DFT" [rho] + sum_i alpha_i [- (E_"Hxc" [rho] - E_"Hxc" [rho - rho_i]) + f_i (E_"Hxc" [rho - rho_i + n_i] - E_"Hxc" [rho - rho_i])] $

- #pause enforces $(d^2 E) / (d f_i^2) = 0 $, where ${f_i}$ is the occupation of some set of orbitals ${phi_i}$
- #pause if ${phi_i}$ are eigenstates then this is GPWL

#matrix-slide(title: "The problem with bulk systems")[
#image(width: 100%, "figures/nguyen_bulk_limit.png")
][
- if applied to eigenstates the correction fails for bulk systems #pause
- compromise: use Wannier functions

#pause

But now we must ask
- why does correcting GPWL for Wannier functions work? #pause
- off-diagonal corrections?
]

= A brief survey

#table(columns: (2fr, 2.5fr, 5fr),
  align: horizon,
  inset: 15pt,
  stroke: none,
  table.header([*method*], [*imposes*], [*with respect to the occupation of...*]),
  [DFT+#emph[U]], [$(d^2 E) / (d (lambda^(I sigma)_i)^2) = 0$], [orbitals that diagonalize $n^(I sigma)$; assumes a subsystem weakly interacting with the bath/frontier orbitals all lie within the subspace],
  [DFT+#emph[U]+#emph[V]], [$(d^2 E) / (d (n^(I J sigma))d(n^(J I sigma))) = 0?$], [orbitals that diagonalize $n^(I sigma)$ mixed with projectors of adjacent sites],
  [DFT+#emph[U]+#emph[J]], [$(d^2 E)/(d (m^I)^2) = 0?$ -- but wrong shape], [same as DFT+#emph[U]],
  [BLOR], [$(d^2 E) / (d n^2) = 0; \ (d^2 E) / (d m^2) = 0$], [projectors],
  [mBLOR], [$(d^2 E) / (d N^2) = 0; \ (d^2 E) / (d M^2) = 0$], [orbitals that diagonalize $n^(I sigma)$],
  [Koopmans (molecules)], [$(d^2 E) / (d f_i^2) = 0 #h(0.5em) forall i$], [KS eigenstates; fails in bulk limit],
  [Koopmans (solids)], [$(d^2 E) / (d f_i^2) = 0 #h(0.5em) forall i$], [Wannier functions; succeeds in bulk limit but subspace definition now arbitrary  and we have a disconnect with GPWL],
  [GSC2 @Mei2021b], [$(d^2 E) / (d f_i^2) = 0 #h(0.5em) forall i$], [KS eigenstates; equivalent to Koopmans for molecules],
  [LOSC @Mahler2022a], [$(d^2 E) / (d f_i d f_j) = 0 #h(0.5em) forall i, j$], [DLWFs (i.e. a set of localized orbitals)],
)


= Where to next?

I am *not* advocating for abandoning pragmatic corrections.

#pause

Open questions: #pause
 - what are the best criteria for choosing the orbitals/subspaces? #pause
   Do we need to turn to...
   - understanding the structure of self-energies@Tamai2019?
   - ensemble DFT?
 - are off-diagonal corrections to these orbitals/subspaces physical?
 - are we expecting too much of our approximations?
   - e.g. BLOR and SCE -- easier with reduced density matrix functional theory?

#focus-slide[Thank you!]

== References
#bibliography("references.bib")
