return function(require)
-- Own installed16.20 data; research/attack-effects-16.20 and Yunara provenance.
local M={}
M.profiles={Yunara={id='normal',q='YunaraQ',w='YunaraW',w2='YunaraW2',e='YunaraE',e2='YunaraE2',r='YunaraR',
 qMax=8,qDuration=5,qSpread=300,qSpreadAD=.3,qOnhit=.3,qBase={3,8,13,18,23},qAP=.2,qAS={.2,.3,.4,.5,.6},
 wRange=1150,wRadius=60,wDelay=.45,wSpeed=2150,wBase={55,95,135,175,215},wAD=.85,wAP=.5,wLinger=1,wDPS=.6,
 w2Radius=90,w2Delay=.6,w2Base={160,320,480},w2AD=1.2,w2AP=.75,
 eDuration=1.5,eMS={.3,.35,.4,.45,.5},eRange=450,eDelay=.05,eSpeeds={1350,1500,1650},rDuration=15,
 -- https://wiki.leagueoflegends.com/en-us/Yunara (read 2026-10-08):
 -- W cast time "0.45 - 0.225 (based on bonus attack speed)", transformed W "0.6 - 0.45". The page publishes the two
 -- end points only, no slope (the reference script's max(.225,.45-.225*(AS-1)) matches the end points and is
 -- unconfirmed), so wDelay/w2Delay stay the constant upper bound; the floors are recorded and not used.
 -- Untouchable Shadow (E during R): target range "225 - 450", speed 1350/1500/1650 by R rank, no cast time
 -- (eDelay .05 is the controller's input margin). The page gives transformed W width 120; w2Radius 90 is the asset's.
 wDelayMin=.225,w2DelayMin=.45,eMinRange=225,
 eSource='https://wiki.leagueoflegends.com/en-us/Yunara Untouchable Shadow: range 225-450, speed 1350/1500/1650 by R rank (read 2026-10-08); CombatProfiles/yunara-provenance.json',
 critMagicRatio=.1,critMagicAP=.001,
 -- Ranking 2026-10-10 (dossier Yunara-1/5/10; https://wiki.leagueoflegends.com/en-us/Template:Data_Yunara/Arc_of_Judgment
 -- read 2026-10-10, "last changed V26.20"):
 --  wMinion: W "deals 50% / 75% / 100% (based on level) damage against minions"; the level breakpoints are not published
 --   (zgYunara 1.02 uses <9 / 9-12 / 13+). Until the yunara_w_minion dev trace settles them, the lowest factor any
 --   plausible split allows is used: 0.5 through level 12, 0.75 from 13 (a rescue never overestimates). Lane minions only;
 --   whether monsters count is not stated, so monsters keep full damage (jungle W is not a kill decision).
 --  wCollide: the bead "slows down significantly while colliding with an enemy" (speed 2150, 150 while colliding); the
 --   duration of the slow phase per unit is unknown, so a W whose ray crosses other units gets no lethal credit
 --   (impact unknown) while it may still be cast (it passes through). Dev trace yunara_w_impact.
 --  w2HitRadius: wiki width 120 (radius 60) vs asset w2Radius 90; prediction uses the smaller, the no-softening scan the larger.
 wMinion={{level=1,factor=.5},{level=13,factor=.75}},w2HitRadius=60}}
local function finite(n)return type(n)=='number'and n==n and n>-math.huge and n<math.huge end
function M.RawQ(rank,ap)
 local p=M.profiles.Yunara
 if not finite(rank)or rank%1~=0 or not p.qBase[rank]or not finite(ap)then return 0,'rank_or_stat_unknown'end
 return p.qBase[rank]+p.qAP*ap,'own_profile_passive_on_hit'
end
return M

end
