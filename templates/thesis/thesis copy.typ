#set text(lang: "en")

// Set font styles
#let font-sans = "Calibri"
#let font-serif = "Linux Libertine"

// ==================================================================================

#pagebreak()


#image("logo/wordmark_black.png", width: 20%)


#align(left + horizon)[
    #set block(below: .65em)
    
    #text(size: 2.25em, weight: "bold", font: font-sans)[
        Titel der Arbeit
    ]

    #text(size: 1.625em, weight: "bold", font: font-sans)[
        Subtitel der Arbeit
    ]

    #v(2em)

    #text(size: 1.5em, font: font-sans)[
        Vorname Name

        Masterarbeit im Studiengang Angewandte Informatik
        
        #v(2em)

        #datetime.today().display("[day].[month].[year]")
    ]
]

#align(right + bottom)[
    #pad(right: 3em)[
        #image("logo/logo_colour.png", width: 20%)
    ]
]

#pagebreak()

// ==================================================================================

// Set font and font size
#set text(12pt, font: font-serif)

// configure paragraph spacing and justify content
#show par: set block(below: 2em)
#set par(
    justify: true,
)

// Make the titles bold, larger and add vertical spacing
// TODO: block margin does not work on outline heading so we added a v(1.5em) 
// => replace with set block(blow: 1.5em) it this is possible soon.
#show heading.where(level: 1): it => {
    set text(1.5em, weight: "bold")
    pagebreak(weak: true)
    v(4em)
    it
}
#show heading.where(level: 2): set text(1.25em, weight: "bold")
#show heading.where(level: 3): set text(1.175em, weight: "bold")
#show heading: it => {
    set text(font: font-sans)
    it
    v(1.25em)
}
#set heading(numbering: "1.1.1")

// Two page layout configuration
#set page(
    margin: (inside: 35mm, outside: 18mm, bottom: 40mm),
    binding: right,
    header: locate(loc => {
        set text(style: "italic")

        let chapter_page = query(
            heading.where(level: 1), loc
        ).find(h => h.location().page() == loc.page())

        if chapter_page == none {
            let chapter = query(
                heading.where(level: 1).or(heading.where(level: 2)).before(loc), loc
            )

            if chapter != () {
                chapter.last().body
            }
        }
        
    }),
    footer: locate(loc => {
        if calc.even(loc.page()) {
            h(1fr)
            str(loc.page())
        } else {
            loc.page()
        }
    })
)

// Table of contents
#show outline.entry.where(
  level: 1
): it => {
  v(1em, weak: true)
  strong(it)
}

// ===========================
#set text(12pt, font: font-sans)

#outline(
    title: auto,
    depth: 3, 
    indent: 2em,
    fill: repeat[. #h(.75em)]
)

#pagebreak()

#set text(12pt, font: font-serif)

= Überschrift auf Ebene 0 (chapter)

#lorem(110)

== Überschrift auf Ebene 1 (section)

#lorem(110)

=== Überschrift auf Ebene 2 (subsection)

#lorem(200)

==== Überschrift auf Ebene 3 (subsubsection)

#lorem(200)

= Listen

- *Content*
    - Text
        - Math
            - Layout
    - Visualize
        - Meta
        - Symbols

+ *Content*
+ Text
    + Math
        + Layout
+ Visualize
    + Meta
    + Symbols

== Topic A

#lorem(200)

#lorem(200)

#lorem(200)
