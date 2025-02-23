{-# OPTIONS --safe --experimental-lossy-unification #-}
module Cubical.ZCohomology.CohomologyRings.Unit where

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Function
open import Cubical.Foundations.Isomorphism

open import Cubical.Data.Nat renaming (_+_ to _+n_ ; _·_ to _·n_)
open import Cubical.Data.Int
open import Cubical.Data.Vec
open import Cubical.Data.FinData

open import Cubical.Algebra.Group
open import Cubical.Algebra.Group.Morphisms
open import Cubical.Algebra.Group.MorphismProperties
open import Cubical.Algebra.Group.Instances.Int renaming (ℤGroup to ℤG)
open import Cubical.Algebra.DirectSum.Base
open import Cubical.Algebra.Ring
open import Cubical.Algebra.CommRing
open import Cubical.Algebra.CommRing.Instances.Int renaming (ℤCommRing to ℤCR)
open import Cubical.Algebra.CommRing.FGIdeal
open import Cubical.Algebra.CommRing.QuotientRing
open import Cubical.Algebra.Polynomials.Multivariate.Base renaming (base to baseP)
open import Cubical.Algebra.Polynomials.Multivariate.EquivCarac.A[X]X-A
open import Cubical.Algebra.CommRing.Instances.MultivariatePoly
open import Cubical.Algebra.CommRing.Instances.MultivariatePoly-Quotient
open import Cubical.Algebra.CommRing.Instances.MultivariatePoly-notationZ

open import Cubical.HITs.Truncation
open import Cubical.HITs.SetQuotients as SQ renaming (_/_ to _/sq_)
open import Cubical.HITs.PropositionalTruncation as PT

open import Cubical.ZCohomology.Base
open import Cubical.ZCohomology.GroupStructure
open import Cubical.ZCohomology.RingStructure.CupProduct
open import Cubical.ZCohomology.RingStructure.CohomologyRing
open import Cubical.ZCohomology.Groups.Unit

open Iso

module Equiv-Unit-Properties where

  open CommRingStr (snd ℤCR) using ()
    renaming
    ( 0r        to 0ℤ
    ; 1r        to 1ℤ
    ; _+_       to _+ℤ_
    ; -_        to -ℤ_
    ; _·_       to _·ℤ_
    ; +Assoc    to +ℤAssoc
    ; +Identity to +ℤIdentity
    ; +Lid      to +ℤLid
    ; +Rid      to +ℤRid
    ; +Inv      to +ℤInv
    ; +Linv     to +ℤLinv
    ; +Rinv     to +ℤRinv
    ; +Comm     to +ℤComm
    ; ·Assoc    to ·ℤAssoc
    ; ·Identity to ·ℤIdentity
    ; ·Lid      to ·ℤLid
    ; ·Rid      to ·ℤRid
    ; ·Rdist+   to ·ℤRdist+
    ; ·Ldist+   to ·ℤLdist+
    ; is-set    to isSetℤ     )

  open RingStr (snd (H*R Unit)) using ()
    renaming
    ( 0r        to 0H*
    ; 1r        to 1H*
    ; _+_       to _+H*_
    ; -_        to -H*_
    ; _·_       to _cup_
    ; +Assoc    to +H*Assoc
    ; +Identity to +H*Identity
    ; +Lid      to +H*Lid
    ; +Rid      to +H*Rid
    ; +Inv      to +H*Inv
    ; +Linv     to +H*Linv
    ; +Rinv     to +H*Rinv
    ; +Comm     to +H*Comm
    ; ·Assoc    to ·H*Assoc
    ; ·Identity to ·H*Identity
    ; ·Lid      to ·H*Lid
    ; ·Rid      to ·H*Rid
    ; ·Rdist+   to ·H*Rdist+
    ; ·Ldist+   to ·H*Ldist+
    ; is-set    to isSetH*     )

  open CommRingStr (snd ℤ[X]) using ()
    renaming
    ( 0r        to 0Pℤ
    ; 1r        to 1Pℤ
    ; _+_       to _+Pℤ_
    ; -_        to -Pℤ_
    ; _·_       to _·Pℤ_
    ; +Assoc    to +PℤAssoc
    ; +Identity to +PℤIdentity
    ; +Lid      to +PℤLid
    ; +Rid      to +PℤRid
    ; +Inv      to +PℤInv
    ; +Linv     to +PℤLinv
    ; +Rinv     to +PℤRinv
    ; +Comm     to +PℤComm
    ; ·Assoc    to ·PℤAssoc
    ; ·Identity to ·PℤIdentity
    ; ·Lid      to ·PℤLid
    ; ·Rid      to ·PℤRid
    ; ·Rdist+   to ·PℤRdist+
    ; ·Ldist+   to ·PℤLdist+
    ; is-set    to isSetPℤ     )

  open CommRingStr (snd ℤ[X]/X) using ()
    renaming
    ( 0r        to 0PℤI
    ; 1r        to 1PℤI
    ; _+_       to _+PℤI_
    ; -_        to -PℤI_
    ; _·_       to _·PℤI_
    ; +Assoc    to +PℤIAssoc
    ; +Identity to +PℤIIdentity
    ; +Lid      to +PℤILid
    ; +Rid      to +PℤIRid
    ; +Inv      to +PℤIInv
    ; +Linv     to +PℤILinv
    ; +Rinv     to +PℤIRinv
    ; +Comm     to +PℤIComm
    ; ·Assoc    to ·PℤIAssoc
    ; ·Identity to ·PℤIIdentity
    ; ·Lid      to ·PℤILid
    ; ·Rid      to ·PℤIRid
    ; ·Rdist+   to ·PℤIRdist+
    ; ·Ldist+   to ·PℤILdist+
    ; is-set    to isSetPℤI     )

-----------------------------------------------------------------------------
-- Direct Sens on ℤ[x]

  ℤ[x]→H*-Unit : ℤ[x] → H* Unit
  ℤ[x]→H*-Unit = Poly-Rec-Set.f _ _ _ isSetH*
                  0H*
                  base-trad
                  _+H*_
                  +H*Assoc
                  +H*Rid
                  +H*Comm
                  base-neutral-eq
                  base-add-eq
               where
               base-trad : _
               base-trad (zero ∷ []) a = base zero (inv (fst H⁰-Unit≅ℤ) a)
               base-trad (suc n ∷ []) a = 0H*

               base-neutral-eq :  _
               base-neutral-eq (zero ∷ []) = base-neutral _
               base-neutral-eq (suc n ∷ []) = refl

               base-add-eq : _
               base-add-eq (zero ∷ []) a b = base-add _ _ _
               base-add-eq (suc n ∷ []) a b = +H*Rid _

  ℤ[x]→H*-Unit-pres1Pℤ : ℤ[x]→H*-Unit (1Pℤ) ≡ 1H*
  ℤ[x]→H*-Unit-pres1Pℤ = refl

  ℤ[x]→H*-Unit-pres+ : (x y : ℤ[x]) → ℤ[x]→H*-Unit (x +Pℤ y) ≡ ℤ[x]→H*-Unit x +H* ℤ[x]→H*-Unit y
  ℤ[x]→H*-Unit-pres+ x y = refl


-- Proving the morphism on the cup product

  T0 : (z : ℤ) → coHom 0 Unit
  T0 = λ z → inv (fst H⁰-Unit≅ℤ) z

  T0g : IsGroupHom (ℤG .snd) (fst (invGroupIso H⁰-Unit≅ℤ) .fun) (coHomGr 0 Unit .snd)
  T0g = snd (invGroupIso H⁰-Unit≅ℤ)


    -- idea : control of the unfolding + simplification of T0 on the left
  pres·-base-case-00 : (a : ℤ) → (b : ℤ) →
                        T0 (a ·ℤ b) ≡ (T0 a) ⌣ (T0 b)
  pres·-base-case-00 (pos zero)       b = (IsGroupHom.pres1 T0g)
  pres·-base-case-00 (pos (suc n))    b = ((IsGroupHom.pres· T0g b (pos n ·ℤ b)))
                                          ∙ (cong (λ X → (T0 b) +ₕ X) (pres·-base-case-00 (pos n) b))
  pres·-base-case-00 (negsuc zero)    b = IsGroupHom.presinv T0g b
  pres·-base-case-00 (negsuc (suc n)) b = cong T0 (+ℤComm (-ℤ b) (negsuc n ·ℤ b)) -- ·ℤ and ·₀ are defined asymetrically !
                                          ∙ IsGroupHom.pres· T0g (negsuc n ·ℤ b) (-ℤ b)
                                          ∙ cong₂ _+ₕ_ (pres·-base-case-00 (negsuc n) b)
                                                         (IsGroupHom.presinv T0g b)


  pres·-base-case-int : (n : ℕ) → (a : ℤ) → (m : ℕ) → (b : ℤ) →
                ℤ[x]→H*-Unit (baseP (n ∷ []) a ·Pℤ baseP (m ∷ []) b)
              ≡ ℤ[x]→H*-Unit (baseP (n ∷ []) a) cup ℤ[x]→H*-Unit (baseP (m ∷ []) b)
  pres·-base-case-int zero    a zero    b = cong (base 0) (pres·-base-case-00 a b)
  pres·-base-case-int zero    a (suc m) b = refl
  pres·-base-case-int (suc n) a m       b = refl

  pres·-base-case-vec : (v : Vec ℕ 1) → (a : ℤ) → (v' : Vec ℕ 1) → (b : ℤ) →
                ℤ[x]→H*-Unit (baseP v a ·Pℤ baseP v' b)
              ≡ ℤ[x]→H*-Unit (baseP v a) cup ℤ[x]→H*-Unit (baseP v' b)
  pres·-base-case-vec (n ∷ []) a (m ∷ []) b = pres·-base-case-int n a m b



  ℤ[x]→H*-Unit-pres· : (x y : ℤ[x]) → ℤ[x]→H*-Unit (x ·Pℤ y) ≡ ℤ[x]→H*-Unit x cup ℤ[x]→H*-Unit y
  ℤ[x]→H*-Unit-pres· = Poly-Ind-Prop.f _ _ _
                         (λ x p q i y j → isSetH* _ _ (p y) (q y) i j)
                         (λ y → refl)
                         base-case
                         λ {U V} ind-U ind-V y → cong₂ _+H*_ (ind-U y) (ind-V y)
    where
    base-case : _
    base-case (n ∷ []) a = Poly-Ind-Prop.f _ _ _ (λ _ → isSetH* _ _)
                           (sym (RingTheory.0RightAnnihilates (H*R Unit) _))
                           (λ v' b → pres·-base-case-vec (n ∷ []) a v' b)
                           λ {U V} ind-U ind-V → (cong₂ _+H*_ ind-U ind-V) ∙ sym (·H*Rdist+ _ _ _)


    -- raising to the product
  ℤ[x]→H*-Unit-cancelX : (k : Fin 1) → ℤ[x]→H*-Unit (<X> k) ≡ 0H*
  ℤ[x]→H*-Unit-cancelX zero = refl

  ℤ[X]→H*-Unit : RingHom (CommRing→Ring ℤ[X]) (H*R Unit)
  fst ℤ[X]→H*-Unit = ℤ[x]→H*-Unit
  snd ℤ[X]→H*-Unit = makeIsRingHom ℤ[x]→H*-Unit-pres1Pℤ ℤ[x]→H*-Unit-pres+ ℤ[x]→H*-Unit-pres·

  ℤ[X]/X→H*R-Unit : RingHom (CommRing→Ring ℤ[X]/X) (H*R Unit)
  ℤ[X]/X→H*R-Unit = Quotient-FGideal-CommRing-Ring.inducedHom ℤ[X] (H*R Unit) ℤ[X]→H*-Unit <X> ℤ[x]→H*-Unit-cancelX

  ℤ[x]/x→H*-Unit : ℤ[x]/x → H* Unit
  ℤ[x]/x→H*-Unit = fst ℤ[X]/X→H*R-Unit



-----------------------------------------------------------------------------
-- Converse Sens on ℤ[X]

  H*-Unit→ℤ[x] : H* Unit → ℤ[x]
  H*-Unit→ℤ[x] = DS-Rec-Set.f _ _ _ _ isSetPℤ
                  0Pℤ
                  base-trad
                  _+Pℤ_
                  +PℤAssoc
                  +PℤRid
                  +PℤComm
                  base-neutral-eq
                  base-add-eq
               where
               base-trad : (n : ℕ) → coHom n Unit → ℤ[x]
               base-trad zero a = baseP (0 ∷ []) (fun (fst H⁰-Unit≅ℤ) a)
               base-trad (suc n) a = 0Pℤ

               base-neutral-eq : _
               base-neutral-eq zero = base-0P _
               base-neutral-eq (suc n) = refl

               base-add-eq : _
               base-add-eq zero a b = base-poly+ _ _ _
                                      ∙ cong (baseP (0 ∷ [])) (sym (IsGroupHom.pres· (snd H⁰-Unit≅ℤ) a b))
               base-add-eq (suc n) a b = +PℤRid _

  H*-Unit→ℤ[x]-pres+ : (x y : H* Unit) → H*-Unit→ℤ[x] ( x +H* y) ≡ H*-Unit→ℤ[x] x +Pℤ H*-Unit→ℤ[x] y
  H*-Unit→ℤ[x]-pres+ x y = refl

  H*-Unit→ℤ[x]/x : H* Unit → ℤ[x]/x
  H*-Unit→ℤ[x]/x = [_] ∘ H*-Unit→ℤ[x]

  H*-Unit→ℤ[x]/x-pres+ : (x y : H* Unit) → H*-Unit→ℤ[x]/x (x +H* y) ≡ (H*-Unit→ℤ[x]/x x) +PℤI (H*-Unit→ℤ[x]/x y)
  H*-Unit→ℤ[x]/x-pres+ x y = cong [_] (H*-Unit→ℤ[x]-pres+ x y)



-----------------------------------------------------------------------------
-- Section

  e-sect : (x : H* Unit) → ℤ[x]/x→H*-Unit (H*-Unit→ℤ[x]/x x) ≡ x
  e-sect = DS-Ind-Prop.f _ _ _ _ (λ _ → isSetH* _ _)
           refl
           base-case
           λ {U V} ind-U ind-V → cong ℤ[x]/x→H*-Unit (H*-Unit→ℤ[x]/x-pres+ U V)
                                  ∙ IsRingHom.pres+ (snd ℤ[X]/X→H*R-Unit) (H*-Unit→ℤ[x]/x U) (H*-Unit→ℤ[x]/x V)
                                  ∙ cong₂ _+H*_ ind-U ind-V
           where
           base-case : _
           base-case zero a = cong (base 0) (leftInv (fst H⁰-Unit≅ℤ) a)
           base-case (suc n) a = (sym (base-neutral (suc n)))
                                 ∙ (cong (base (suc n)) ((isContr→isProp (isContrHⁿ-Unit n) _ a)))


-----------------------------------------------------------------------------
-- Retraction

  e-retr : (x : ℤ[x]/x) → H*-Unit→ℤ[x]/x (ℤ[x]/x→H*-Unit x) ≡ x
  e-retr = SQ.elimProp (λ _ → isSetPℤI _ _)
           (Poly-Ind-Prop.f _ _ _ (λ _ → isSetPℤI _ _)
           refl
           base-case
           λ {U V} ind-U ind-V → cong₂ _+PℤI_ ind-U ind-V)
           where
           base-case : _
           base-case (zero ∷ []) a = refl
           base-case (suc n ∷ []) a = eq/ 0Pℤ (baseP (suc n ∷ []) a) ∣ ((λ x → baseP (n ∷ []) (-ℤ a)) , foo) ∣₁
             where
             foo : (0P poly+ baseP (suc n ∷ []) (- a)) ≡ (baseP (n +n 1 ∷ []) (- a · pos 1) poly+ 0P)
             foo = (0P poly+ baseP (suc n ∷ []) (- a)) ≡⟨ +PℤLid _ ⟩
                   baseP (suc n ∷ []) (- a) ≡⟨ cong₂ baseP (cong (λ X → X ∷ []) (sym ((+-suc n 0)
                                              ∙ (cong suc (+-zero n))))) (sym (·ℤRid _)) ⟩
                   baseP (n +n suc 0 ∷ []) (- a ·ℤ 1ℤ) ≡⟨ refl ⟩
                   baseP (n +n 1 ∷ []) (- a · pos 1) ≡⟨ sym (+PℤRid _) ⟩
                   (baseP (n +n 1 ∷ []) (- a · pos 1) poly+ 0P) ∎



-----------------------------------------------------------------------------
-- Computation of the Cohomology Ring

module _ where

  open Equiv-Unit-Properties
  open RingEquivs

  Unit-CohomologyRingP : RingEquiv (CommRing→Ring ℤ[X]/X) (H*R Unit)
  fst Unit-CohomologyRingP = isoToEquiv is
    where
    is : Iso ℤ[x]/x (H* Unit)
    fun is = ℤ[x]/x→H*-Unit
    inv is = H*-Unit→ℤ[x]/x
    rightInv is = e-sect
    leftInv is = e-retr
  snd Unit-CohomologyRingP = snd ℤ[X]/X→H*R-Unit

  CohomologyRing-UnitP : RingEquiv (H*R Unit) (CommRing→Ring ℤ[X]/X)
  CohomologyRing-UnitP = invEquivRing Unit-CohomologyRingP

  Unit-CohomologyRingℤ : RingEquiv (CommRing→Ring ℤCR) (H*R Unit)
  Unit-CohomologyRingℤ = compRingEquiv (invEquivRing Equiv-ℤ[X]/X-ℤ) Unit-CohomologyRingP

  CohomologyRing-Unitℤ : RingEquiv (H*R Unit) (CommRing→Ring ℤCR)
  CohomologyRing-Unitℤ = compRingEquiv CohomologyRing-UnitP Equiv-ℤ[X]/X-ℤ
