```mermaid
classDiagram
  namespace SO_AFU_Bodeneinheiten_20251210__Bodeneinheiten {
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Auspraegung["Auspraegung"] {
      <<Abstract>>
      Bemerkungen[0..1] : String
      Bodenpunktzahl[1] : Numeric
      Bodentyp[1] : BodentypCode
      Gelaendeform[1] : Gelaendeform
      Geologie[1] : String
      Gewichtung[1] : Numeric
      Humusgehalt_ah[1] : Numeric
      Import_OID[0..1] : Numeric
      Karbonatgrenze[1] : Numeric
      Maechtigkeit_ah[1] : Numeric
      Ohne_Oberboden[1] : BOOLEAN
      Ohne_Unterboden[1] : BOOLEAN
      Pflanzennutzbaregruendigkeit[1] : Numeric
      Untertyp_E[1] : Untertyp_E_Enum
      Untertyp_G[0..1] : Untertyp_G_Enum
      Untertyp_I[0..1] : Untertyp_I_Enum
      Untertyp_R[0..1] : Untertyp_R_Enum
      Wasserhaushalt[1] : WasserhaushaltCode_Enum
      CheckBodentypM_HumusAh()
      CheckBodentypUntertypen()
      CheckWasserhaushaltPflanzennutzbaregruendigkeit()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung["BodeneinheitHauptauspraegung"] {
      <<Abstract>>
      Alte_Daten_Vorhanden[1] : Alte_Daten_vorhanden_Enum
      Gemeinde_Nr[1] : Numeric
      Geometrie[0..1] : Area
      Kartierjahr[1] : Numeric
      Kartierquartal[1] : Numeric
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Landwirtschaft["BodeneinheitHauptauspraegung_Landwirtschaft"] {
      Bodeneinheit_Nummer[1] : Numeric
      Oberboden[0..1] : Oberboden_Landwirtschaft
      Unterboden[0..1] : Unterboden_Landwirtschaft
      CheckKalkgrenzeKalkgehalt_Land()
      GewichtungSumme100_Land()
      Landwirtschaft_Oberboden_present_if_flag_true()
      Landwirtschaft_Oberboden_required_if_flag_false()
      Landwirtschaft_UniqueBodeneinheitProGemeinde()
      Landwirtschaft_Unterboden_present_if_flag_true()
      Landwirtschaft_Unterboden_required_if_flag_false()
      UntertypENachPH_Unterboden_Land()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Wald["BodeneinheitHauptauspraegung_Wald"] {
      Bodeneinheit_Nummer[1] : Numeric
      Humusform_wald[1] : Humusform_wald
      Maechtigkeit_ahh[0..1] : Numeric
      Oberboden[0..1] : Oberboden_Wald
      Unterboden[0..1] : Unterboden_Wald
      CheckKalkgrenzeKalkgehalt_Wald()
      GewichtungSumme100_Wald()
      UntertypENachPH_Unterboden_Wald()
      Wald_Oberboden_present_if_flag_true()
      Wald_Oberboden_required_if_flag_false()
      Wald_UniqueBodeneinheitProGemeinde()
      Wald_Unterboden_present_if_flag_true()
      Wald_Unterboden_required_if_flag_false()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Los["Los"] {
      Los[1] : String
      Mit_Geometrie[1] : BOOLEAN
      Publizieren[1] : BOOLEAN
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Landwirtschaft["Nebenauspraegung_Landwirtschaft"] {
      Oberboden[0..1] : Oberboden_Landwirtschaft
      Unterboden[0..1] : Unterboden_Landwirtschaft
      CheckKalkgrenzeKalkgehalt_Land_Neben()
      HauptHatMehrGewicht_alsNeben_Landwirtschaft()
      Neben_Landwirtschaft_Oberboden_present_if_flag_true()
      Neben_Landwirtschaft_Oberboden_required_if_flag_false()
      Neben_Landwirtschaft_Unterboden_present_if_flag_true()
      Neben_Landwirtschaft_Unterboden_required_if_flag_false()
      UntertypENachPH_Unterboden_Land_Neben()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Wald["Nebenauspraegung_Wald"] {
      Humusform_wald[1] : Humusform_wald
      Maechtigkeit_ahh[0..1] : Numeric
      Oberboden[0..1] : Oberboden_Wald
      Unterboden[0..1] : Unterboden_Wald
      CheckKalkgrenzeKalkgehalt_Wald_Neben()
      HauptHatMehrGewicht_alsNeben_Wald()
      Neben_Wald_Oberboden_present_if_flag_true()
      Neben_Wald_Oberboden_required_if_flag_false()
      Neben_Wald_Unterboden_present_if_flag_true()
      Neben_Wald_Unterboden_required_if_flag_false()
      UntertypENachPH_Unterboden_Wald_Neben()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Oberboden_Landwirtschaft["Oberboden_Landwirtschaft"] {
      <<Structure>>
      Gefuegeform[1] : Gefuegeform
      Gefuegegroesse[0..1] : Gefuegegroesse
      Kalkgehalt[1] : Kalkgehalt
      Koernungsklasse[1] : Koernungsklasse
      Ph[1] : Numeric
      Schluffgehalt[1] : Numeric
      Skelettgehalt_Oberboden[0..1] : Skelettgehalt_Landwirtschaft
      Tongehalt[1] : Numeric
      CheckKoernungsklasseObSchluff_Land()
      CheckKoernungsklasseObTongehalt_Land()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Oberboden_Wald["Oberboden_Wald"] {
      <<Structure>>
      Gefuegeform[1] : Gefuegeform
      Gefuegegroesse[0..1] : Gefuegegroesse
      Kalkgehalt[1] : Kalkgehalt
      Koernungsklasse[1] : Koernungsklasse
      Ph[1] : Numeric
      Schluffgehalt[1] : Numeric
      Skelettgehalt_Oberboden[0..1] : Skelettgehalt_Wald
      Tongehalt[1] : Numeric
      CheckKoernungsklasseObSchluff_Wald()
      CheckKoernungsklasseObTongehalt_Wald()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Unterboden_Landwirtschaft["Unterboden_Landwirtschaft"] {
      <<Structure>>
      Gefuegeform[0..1] : Gefuegeform
      Gefuegegroesse[0..1] : Gefuegegroesse
      Kalkgehalt[0..1] : Kalkgehalt
      Koernungsklasse[0..1] : Koernungsklasse
      Ph[0..1] : Numeric
      Schluffgehalt[0..1] : Numeric
      Skelettgehalt_Unterboden[0..1] : Skelettgehalt_Landwirtschaft
      Tongehalt[0..1] : Numeric
      CheckKoernungsklasseUbSchluff_Land()
      CheckKoernungsklasseUbTongehalt_Land()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Unterboden_Wald["Unterboden_Wald"] {
      <<Structure>>
      Gefuegeform[0..1] : Gefuegeform
      Gefuegegroesse[0..1] : Gefuegegroesse
      Kalkgehalt[0..1] : Kalkgehalt
      Koernungsklasse[0..1] : Koernungsklasse
      Ph[0..1] : Numeric
      Schluffgehalt[0..1] : Numeric
      Skelettgehalt_Unterboden[0..1] : Skelettgehalt_Wald
      Tongehalt[0..1] : Numeric
      CheckKoernungsklasseUbSchluff_Wald()
      CheckKoernungsklasseUbTongehalt_Wald()
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_HauptLandwirtschaft["Untertyp_Diverse_HauptLandwirtschaft"] {
      Code[1] : Untertyp_Diverse_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_HauptWald["Untertyp_Diverse_HauptWald"] {
      Code[1] : Untertyp_Diverse_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_NebenLandwirtschaft["Untertyp_Diverse_NebenLandwirtschaft"] {
      Code[1] : Untertyp_Diverse_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_NebenWald["Untertyp_Diverse_NebenWald"] {
      Code[1] : Untertyp_Diverse_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_HauptLandwirtschaft["Untertyp_K_HauptLandwirtschaft"] {
      Code[1] : Untertyp_K_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_HauptWald["Untertyp_K_HauptWald"] {
      Code[1] : Untertyp_K_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_NebenLandwirtschaft["Untertyp_K_NebenLandwirtschaft"] {
      Code[1] : Untertyp_K_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_NebenWald["Untertyp_K_NebenWald"] {
      Code[1] : Untertyp_K_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_HauptLandwirtschaft["Untertyp_P_HauptLandwirtschaft"] {
      Code[1] : Untertyp_P_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_HauptWald["Untertyp_P_HauptWald"] {
      Code[1] : Untertyp_P_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_NebenLandwirtschaft["Untertyp_P_NebenLandwirtschaft"] {
      Code[1] : Untertyp_P_Enum
    }
    class SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_NebenWald["Untertyp_P_NebenWald"] {
      Code[1] : Untertyp_P_Enum
    }
  }
  namespace SO_AFU_Bodeneinheiten_20251210__Excel_Import {
    class SO_AFU_Bodeneinheiten_20251210.Excel_Import.Import_Table["Import_Table"] {
      Import_Fehler[0..1] : String
      Ohne_Oberboden[1] : BOOLEAN
      Ohne_Unterboden[1] : BOOLEAN
      bemerkungen[0..1] : String
      bodentyp[1] : BodentypCode
      bodpktzahl[1] : Numeric
      gefuegeform_ob[0..1] : Gefuegeform
      gefuegeform_ub[0..1] : Gefuegeform
      gefueggr_ob[0..1] : Numeric
      gefueggr_ub[0..1] : Numeric
      gelform[1] : Gelaendeform
      gemnr[1] : Numeric
      geologie[1] : String
      gewichtung_auspraegung[1] : Numeric
      humusform_wa[0..1] : Humusform_wald
      humusgeh_ah[1] : Numeric
      is_wald[1] : BOOLEAN
      ist_hauptauspraegung[1] : BOOLEAN
      kalkgeh_ob[0..1] : Numeric
      kalkgeh_ub[0..1] : Numeric
      karbgrenze[1] : Numeric
      kartierer[1] : String
      kartierjahr[1] : Numeric
      kartierquartal[1] : Numeric
      koernkl_ob[1] : Numeric
      koernkl_ub[0..1] : Numeric
      los[1] : String
      maechtigk_ah[1] : Numeric
      maechtigk_ahh[0..1] : Numeric
      objnr[1] : Numeric
      pflngr[1] : Numeric
      ph_ob[0..1] : Numeric
      ph_ub[0..1] : Numeric
      schluff_ob[0..1] : Numeric
      schluff_ub[0..1] : Numeric
      skelett_ob[1] : Numeric
      skelett_ub[0..1] : Numeric
      ton_ob[0..1] : Numeric
      ton_ub[0..1] : Numeric
      untertyp_div[0..1] : String
      untertyp_e[1] : Untertyp_E_Enum
      untertyp_g[0..1] : Untertyp_G_Enum
      untertyp_i[0..1] : Untertyp_I_Enum
      untertyp_k[0..1] : String
      untertyp_p[0..1] : String
      untertyp_r[0..1] : Untertyp_R_Enum
      wasserhhgr[1] : WasserhaushaltCode_Enum
    }
  }
  namespace SO_AFU_Bodeneinheiten_20251210__Kartierer {
    class SO_AFU_Bodeneinheiten_20251210.Kartierer.KartierPerson["KartierPerson"] {
      Name[1] : String
      Vorname[0..1] : String
    }
    class SO_AFU_Bodeneinheiten_20251210.Kartierer.KartierTeam["KartierTeam"] {
      TeamKuerzel[1] : String
    }
  }
  class SO_AFU_Bodeneinheiten_20251210.Alte_Daten_vorhanden_Enum["Alte_Daten_vorhanden_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.BodentypCode["BodentypCode"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Gefuegeform["Gefuegeform"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Gefuegegroesse["Gefuegegroesse"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Gelaendeform["Gelaendeform"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Humusform_wald["Humusform_wald"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Kalkgehalt["Kalkgehalt"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Koernungsklasse["Koernungsklasse"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Skelettgehalt_Landwirtschaft["Skelettgehalt_Landwirtschaft"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Skelettgehalt_Wald["Skelettgehalt_Wald"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Untertyp_Diverse_Enum["Untertyp_Diverse_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Untertyp_E_Enum["Untertyp_E_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Untertyp_G_Enum["Untertyp_G_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Untertyp_I_Enum["Untertyp_I_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Untertyp_K_Enum["Untertyp_K_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Untertyp_P_Enum["Untertyp_P_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.Untertyp_R_Enum["Untertyp_R_Enum"] {
    <<Enumeration>>
  }
  class SO_AFU_Bodeneinheiten_20251210.WasserhaushaltCode_Enum["WasserhaushaltCode_Enum"] {
    <<Enumeration>>
  }
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung --|> SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Auspraegung
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Landwirtschaft --|> SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Wald --|> SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Landwirtschaft --|> SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Auspraegung
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Wald --|> SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Auspraegung
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung "0..*" -- "1" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Los : BodeneinheitHauptAssociation_Los–los
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung "0..*" -- "1" SO_AFU_Bodeneinheiten_20251210.Kartierer.KartierTeam : BodeneinheitHauptauspraegung_r–Kartierer_r
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Landwirtschaft "1" -- "0..3" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Landwirtschaft : Bodeneinheit–Nebenauspraegung
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Landwirtschaft "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_HauptLandwirtschaft : BodeneinheitLandAssociation_Diverse–Untertyp_Diverse_Association_Land
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Landwirtschaft "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_HauptLandwirtschaft : BodeneinheitLandAssociation_K–Untertyp_K_Association_Land
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Landwirtschaft "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_HauptLandwirtschaft : BodeneinheitLandAssociation_P–Untertyp_P_Association_Land
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Wald "1" -- "0..3" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Wald : Bodeneinheit–Nebenauspraegung
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Wald "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_HauptWald : BodeneinheitWaldAssociation_Diverse–Untertyp_Diverse_Association_Wald
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Wald "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_HauptWald : BodeneinheitWaldAssociation_K–Untertyp_K_Association_Wald
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.BodeneinheitHauptauspraegung_Wald "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_HauptWald : BodeneinheitWaldAssociation_P–Untertyp_P_Association_Wald
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Landwirtschaft "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_NebenLandwirtschaft : NebenauspraegungLandAssociation_Diverse–Untertyp_Diverse_Association_Land
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Landwirtschaft "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_NebenLandwirtschaft : NebenauspraegungLandAssociation_K–Untertyp_K_Association_Land
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Landwirtschaft "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_NebenLandwirtschaft : NebenauspraegungLandAssociation_P–Untertyp_P_Association_Land
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Wald "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_Diverse_NebenWald : NebenauspraegungWaldAssociation_Diverse–Untertyp_Diverse_Association_Wald
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Wald "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_K_NebenWald : NebenauspraegungWaldAssociation_K–Untertyp_K_Association_Wald
  SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Nebenauspraegung_Wald "1" -- "0..10" SO_AFU_Bodeneinheiten_20251210.Bodeneinheiten.Untertyp_P_NebenWald : NebenauspraegungWaldAssociation_P–Untertyp_P_Association_Wald

  SO_AFU_Bodeneinheiten_20251210.Kartierer.KartierPerson "1..*" -- "0..*" SO_AFU_Bodeneinheiten_20251210.Kartierer.KartierTeam : KartierPerson_r–KartierTeam_r
```mermaid
