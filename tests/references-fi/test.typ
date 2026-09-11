#import "/src/lib.typ" as template
#import "/src/core/config.typ": setup-document, setup-body-page
#import "/src/sections/bibliography.typ": render-bibliography

#let language = "fi"

// Apply base fonts and text settings
#show: setup-document.with(
  title: "Does not matter here",
  authors: ("Not used here",),
  language: language
)

// Apply body-page geometry and heading styles.
#show: setup-body-page

// Borrow functionality from template.typ wrapper:
#set heading(numbering: "1.1")
// Visible page numbering only starts from the main body (e.g. "Johdanto") onwards
#set page(numbering: "1", number-align: top + right)
#counter(page).update(1)

= Testiluvun otsikko

Kirja @vilkkaTutkiJaKehita2021[s.~10--14].
Julkaisusarjan julkaisu @lerkkanenOpettajienTyohyvinvointiJa2020[s.~5--7].
Celia-äänikirja @hirsjarviTutki2007.
Artikkeli @vilkkaTarinoillaTasaarvoon2019.
Kokoomateoksen artikkeli @fordCellCycleRegulatory2004.
Sanomalehden verkkoartikkeli @paukkuTekoalyVoiMuokata2022.
Organisaation verkkosivu @kuntaliittoAlueiden.
Intranet-dokumentti @keranenIntranet2023.
Opinnäytetyö @korhonenVuokatti2018.
Laki @lakiTietosuojalaki2018.
Standardi @sfs21502.

Tilastolähde @tilastokeskusHotellien2020.
Luento @jokinenLuento2017.
Webinaari @janttiWebinaari2022[00:01:15--00:02:30].
Henkilökohtainen tiedonanto @alasalmiEmail2018.
Podcast @lundbergPodcast2023.
Instagram-julkaisu @nasaInstagram2022.
Peli @vollmerThrees2014.
Verkkojulkaisu @vaswaniAttentionAllYou2023.
Tilauspalvelun e-kirja @gutmanBecomingDataHead2021.
Fallback @failsafeFallback.

#template.render-bibliography(language: language, source: path("testreferences.bib"))
