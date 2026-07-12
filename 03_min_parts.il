; Independent minimal geometry parts. Each function can be tested separately
; from a writable layout cellView.

procedure(DAminDrawM4Outer(cv Pw Ps Ra)
  let((top bottom left right)
    top = 25.0 * Ra
    bottom = -25.0 * Ra
    left = -35.0
    right = 35.0
    DAminPathPoly(cv "M4" list(left:top right:top right:bottom left:bottom) Pw)
  )
)

procedure(DAminDrawM3Inner(cv Pw Ps Ra)
  let((top bottom left right offset)
    offset = Pw + Ps
    top = 25.0 * Ra
    bottom = -25.0 * Ra
    left = -35.0 + offset
    right = 35.0 - offset
    DAminPathPoly(cv "M3" list(left:top left:bottom right:bottom right:top) Pw)
  )
)

procedure(DAminDrawM5Bridge(cv Pw Ra)
  let((y)
    y = 25.0 * Ra + 12.0
    DAminPathPoly(cv "M5" list(-35.0:y 35.0:y) max(5.0 Pw))
  )
)

procedure(DAminDrawCrossVias(cv m4Fig m3Fig m5Fig)
  let(())
    DAminOverlapVia(cv "VIA4" m4Fig m3Fig 0.75 0.50 3.0 3.0 1.5 1.5 1 2)
    DAminOverlapVia(cv "VIA5" m4Fig m5Fig 1.00 1.00 4.0 4.0 2.0 2.0 1 1)
  )
)

procedure(DAminDrawPins(cv Pw Ra)
  let((top bottom)
    top = 25.0 * Ra + 12.0
    bottom = -25.0 * Ra
    DAminCreatePin(cv "P1" "M5" -40.0:top-2.5 -35.0:top+2.5 -40.0:top "centerRight")
    DAminCreatePin(cv "P2" "M5" 35.0:top-2.5 40.0:top+2.5 40.0:top "centerLeft")
    DAminCreatePin(cv "P3" "M3" -25.0:bottom-Pw -20.0:bottom -25.0:bottom "centerRight")
    DAminCreatePin(cv "P4" "M3" 20.0:bottom 25.0:bottom+Pw 25.0:bottom "centerLeft")
  )
)

procedure(DAminDrawAllParts(cv Pw Ps Ra)
  let((m4Fig m3Fig m5Fig)
    m4Fig = DAminDrawM4Outer(cv Pw Ps Ra)
    m3Fig = DAminDrawM3Inner(cv Pw Ps Ra)
    m5Fig = DAminDrawM5Bridge(cv Pw Ra)
    DAminDrawCrossVias(cv m4Fig m3Fig m5Fig)
    DAminDrawPins(cv Pw Ra)
    list(m4Fig m3Fig m5Fig)
  )
)
