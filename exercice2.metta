; (Parent Father)
; (Parent Mother)


(Parent Chandler John)
(Parent Chandler Pam)
(Parent Chandler Adam)
(Parent Chandler Jane)

(Parent Monica John)
(Parent Monica Pam)
(Parent Monica Adam)
(Parent Monica Jane)

(Parent John Bob)
(Parent Pam Tim)
(Parent Pam Kim)
(Parent Adam Eve)
(Parent Jane Joey)

(M Chandler)
(F Monica)

(M John)
(F Pam)
(M Adam)
(F Jane)

(M Bob)
(M Tim)
(F Kim)
(F Eve)
(M Joey)


(= (get-parent $child) (match &self (Parent $x $child) $x) )

(= (get-siblings $child)
    (match &self (Parent $x $child)
        (match &self (, (Parent $x $sibling)
                        (M $x)
                      )
            (if (== $sibling $child) () ($sibling))
        )
    )
)


( = (get-uncle $child)
    (match &self (Parent $x $child)
        (match &self (,(Parent $y $x)
                        (Parent $y $brother)
                        (M $brother)
                        (M $y) ; limit the result to the male parent
                     )
        $brother)
    )
)


( = (get-nephew $uncle)
    (match &self (,(Parent $x $uncle)
                   (M $x) ; limit the result to the male parent
                    )
        (match &self (,(Parent $x $y)
                        (Parent $y $nephew)
                        (M $nephew)
                     )
            (if (== $y $uncle) () ($nephew))
        )
    )
)


; Get the Parents of John.
!(get-parent John)

;Get the Mother of Pam.
!(match &self (,(Parent $x Pam)
                (F $x)

              )
              $x
)

;Get the Siblings of Pam.
!(get-siblings Pam)


; Get the Uncles of Tim.relation
!(get-uncle Tim)


;Get the Nephews of John.
!(get-nephew John)


; Get all Predecessors of Bob
(= (parent $x $y) (match &self (Parent $x $y) $x))
(= (get-predecessor $x $y) (parent $x $y))
(= (get-predecessor $x $y) (get-predecessor $x (parent $x $y)))
!(get-predecessor $x Bob)