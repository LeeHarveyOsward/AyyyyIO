return function(require)
return function()
-- Shared Normal Xerath data; no Classic mechanics are inferred.
return {
 Xerath={id='normal',q='XerathArcanopulseChargeUp',q2='XerathArcanopulse2',w='XerathArcaneBarrage2',e='XerathMageSpear',r='XerathLocusOfPower2',shot='XerathRMissileWrapper',pulse='XerathLocusPulse',
 qBase={70,110,150,190,230},wBase={50,85,120,155,190},eBase={70,100,130,160,190},rBase={170,220,270},shots={4,5,6},
 -- Peel distance for E on an enemy standing next to Xerath: a controller choice (reference lead zgXerath:150-153), not a game value.
 peelRange=350,
 -- Q charge, conservative side of a conflict (xerath-provenance.json q.conflict): asset/ddragon 750->1500 over 1.5 s
 -- from the buff, 4 s charge; wiki V26.17 (read 2026-10-10) 700->1450 over 1.5-1.75 s after a 0-0.25 s onset,
 -- 3 s maximum channel. Until the xerath_q_range dev trace settles it, the fallback range uses the wiki minimum and
 -- maximum, the slower growth and the full onset, and a charge is released within 3 s.
 qMin=700,qMax=1450,qOnset=.25,qGrowth=1.75,qCharge=3,
 -- R recast spacing per shot (wiki V26.17 0.627 s; rivals agree). Used for the shot budget only.
 rShot=.627,
 -- Xerath-5: while more than this much channel time is left beyond the remaining shots, a shot waits for a
 -- precise hit (controller choice, dossier Xerath-5).
 rSlack=.7,
 -- Xerath-7: a target that left vision this recently is revealed (Core:Reveal) and may take one shot at its
 -- advanced position within rBlind seconds of vanishing (controller choices; R radius 200).
 rVanish=.5,rBlind=.25,
 -- Mana Surge on-hit buff (candidate name from the asset buff list; live verification pending).
 passive='XerathAscended2OnHit'}
}

end
end
