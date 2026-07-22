# Gladiator Goodness - Character Stats & Combat Sequence

**Version:** 0.1 (Draft)  
**Date:** July 17, 2026  
**Based on:** table.csv + discussion with Derek

## Primary Attributes (Roots)
These are the core character stats trained and improved over time.

1. **Vitality** — Max Health, sustain, training recovery, essence base quality
2. **Endurance** — Max Stamina, stamina regen, fatigue resistance (especially vs rapid-attack stances)
3. **Strength** — Base damage, ability power, forging, capture success
4. **Agility** — Attack speed, dodge chance, initiative, sourcing evasion
5. **Precision** — Accuracy, crit chance, essence/loot quality
6. **Resilience** — Secondary defense (esp. vs crits), status effect resistance (poison, confusion, intimidation, debuffs)
7. **Charisma** — Crowd influence, stance spectacle, recruitment/morale, defense vs intimidation

## Secondary / Derived Stats
These are used in actual calculations and modified by gear, essences, stances, personality, crowd, etc.

**Core Combat Secondaries:**
- Max Health (Vitality)
- Max Stamina & Stamina Regen (Endurance)
- Base Damage / Ability Power (Strength)
- Attack Speed / Initiative (Agility)
- Dodge Chance (Agility) — successful dodges cost stamina
- Accuracy / Hit Chance (Precision)
- Crit Chance (Precision)
- Crit Damage Multiplier (Precision + Strength)
- **Primary Damage Reduction** (Gear only — diminishing returns)
- **Secondary Defense vs Crits** (Resilience)
- **Adaptation** (independent float) — time spent in a stance before re-evaluation
- Stance Affinity / Trigger Weighting (personality + Charisma)
- Crowd Influence / Hype Generation (Charisma + personality)

**Status & Meta Secondaries:**
- Status Resistance (Resilience)
- Intimidation Resistance (Charisma)
- Essence Potency (Vitality + Precision + **Charisma** of fallen gladiator)
- Cunning (independent value for stance fluidity)

**Non-Combat / Guild Secondaries:** (deferred)
- Training recovery, forging, capture success, recruitment, morale, loot quality, etc.

## Personality Traits (Dual Setup)
- **Combat Personality**: Weights stance selection, duration (via Adaptation), and crowd reaction responses.
- **Non-Combat Personality**: Affects guild/hub interactions.
- No "bad" traits — situational strengths/offsets (e.g., hyper-aggressive fighter stays offensive longer).

**Crowd Excitement**: Driven by big moments (crits, dodges, dramatic plays) modulated by personality. Generates case-by-case buffs/debuffs. Combat strongly feeds crowd; crowd selectively influences combat.

## High-Level Combat Sequence (Per Attack/Ability)
Fully automated. AI selects stances/abilities based on personality, stats, situation, and Adaptation.

1. **Pre-Combat / Start-of-Battle**  
   Apply intimidation debuffs (resisted by Charisma/Resilience).

2. **Stance Selection / Update**  
   AI evaluates. **Adaptation** float controls commitment duration. Changes only between moves.

3. **Ability / Attack Initiation**  
   Pay stamina cost (Endurance mitigates). Choose target/ability.

4. **Accuracy / Hit Check**  
   Precision vs Agility/dodge. Successful dodge: stamina penalty + crowd hype.

5. **Base Damage Calculation**  
   Strength + weapon/ability + stance/gear.

6. **Primary Defense Mitigation**  
   Gear-based reduction (diminishing returns). Never 100%.

7. **Crit Roll** (post-primary defense)  
   Precision chance → multiplier → **Resilience secondary defense** on crit portion.

8. **Final Damage & Effects**  
   Apply to Health. Trigger status effects (Resilience mitigation). Generate crowd excitement.

9. **Crowd Influence Phase**  
   Update hype meter. Apply personality-dependent buffs/debuffs.

10. **Cleanup / Regen**  
	Stamina regen, cooldowns (Agility), death → essence harvest (Charisma-scaled).

---

This document will be referenced for implementation. Update as needed.
