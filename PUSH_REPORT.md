# Informe de sesión — lean-zero-free-regions (empuje M0→región + M2-base)

## Plantilla §B2

```
HECHO:
  Rama push/m0-polydisc (candidato a main, 0 sorry, 0 axiom):
    Polydisc.lean — CIERRA EL HUECO DE HONESTIDAD DECLARADO EN T0. El
      KPCriterion del madre lee la actividad solo a través de ‖z(Y)‖, luego
      es monótono bajo dominación puntual (kpCriterion_withActivity_of_le);
      corolario: partition_withActivity_ne_zero_of_kp — UN peso KP
      certifica Z ≠ 0 en TODO el polidisco cerrado
      {z' : ‖z'(X)‖ ≤ ‖z(X)‖}. "El polidisco de convergencia" deja de ser
      una hipótesis representada y pasa a ser teorema. Además: la sección
      de fugacidad w ↦ Ξ(w·z) es un polinomio explícito en w
      (partition_diskFamily_eq) y por tanto entera
      (analyticOn_partition_diskFamily) — con el no-anulamiento en el disco
      cerrado, ese es el sustrato completo de M1.
    LeeYangSingleBond.lean — primer contenido M2 real:
      AllZerosOnUnitCircle.mul (cierre por productos, paso 0 de la
      tensorización de Asano) y el teorema del bond único: los ceros de
      z² + 2cz + 1 (c real, |c| ≤ 1) están en el círculo unidad, probado
      por álgebra de conjugación pura (z y z̄ son raíces; o z + z̄ = −2c y
      la ecuación fuerza z·z̄ = 1, o z es real y (x+c)² = c²−1 ≤ 0 fuerza
      x = −c, c² = 1). Sin fórmula cuadrática. Primer
      LeeYangCircleHypothesis DESCARGADO del repo.
    Dictionary.lean — re-export literal de
      riemannZeta_ne_zero_of_one_lt_re de Mathlib como lado
      número-teórico del patrón del DICTIONARY.md. MARCADO COMO DESCARTABLE:
      si el Revisor lee M4 como solo-documentación, borrar el archivo;
      nada depende de él. Cero claims nuevos; nada sobre Re s ≤ 1.
    HYPOTHESIS_FRONTIER.md actualizado. Barrel extendido solo aditivamente.
  Rama frontier/M1-M2 (statements-first, sorried, NUNCA a main):
    Frontier/AnalyticLog.lean — log analítico en el disco abierto (M1);
      empalme del log con clusterSum del madre; y el LEMA DE CONTRACCIÓN DE
      ASANO en la forma multiafín clásica (Asano 1970/Ruelle) — el paso de
      inducción de Lee-Yang cuyo caso base ya es teorema en main.
SIGUIENTE: verificar CI en push/m0-polydisc; luego asano_contraction como
  unidad (es un lema clásico autocontenido de una página; con él + el caso
  base + el cierre por productos, M2 tiene todos sus engranajes).
BLOQUEOS: ninguno. La fricción de API con el madre fue CERO: KPCriterion
  estaba formulado exactamente en la forma (normas) que hace la monotonía
  demostrable — señal de buen diseño del madre, digno de mención en el
  fleet-digest.
IMPACTO-INTERFAZ: Interfaces.lean (contrato) INTACTO. Barrel con tres
  imports aditivos. withActivity/diskFamily se definen en el namespace
  YangMills.KP.PolymerSystem vía _root_ — son EXTENSIONES locales de este
  satélite, no cambios en el madre; si el madre quiere adoptarlas
  upstream, issue en el madre (candidatas naturales: son 6 líneas).
HONESTIDAD: (1) Enunciado de Asano corregido durante la sesión a la forma
  multiafín verdadera (una primera redacción ad-hoc era matemáticamente
  dudosa y se descartó: los frontier statements también deben ser
  verdaderos). (2) Dictionary.lean roza el anti-goal de M4 y por eso va
  marcado DESCARTABLE con instrucción de borrado limpio — decisión del
  Revisor. (3) El patch venía escrito sin build local; al aplicar este
  paquete se corrigieron nombres/instancias menores del pin y se verificó
  localmente con `lake build LeanZeroFreeRegions` y el guard de no-sorry.
```

## Cómo aplicar

```bash
git fetch origin
git checkout -b push/m0-polydisc origin/main
git am 0001-*.patch
git push -u origin push/m0-polydisc     # CI juzga; si verde → PR a main
git checkout -b frontier/M1-M2
git am 0002-*.patch
git push -u origin frontier/M1-M2
```

## VERIFICATION — estado del build local

Verificado al aplicar el paquete sobre `3a7d277`:

- `lake build LeanZeroFreeRegions`: verde.
- `powershell -ExecutionPolicy Bypass -File scripts/check_no_sorry.ps1`: verde.
- Ajustes realizados sobre el patch original: imports del barrel movidos al
  encabezado Lean; instancia `Fintype` de `withActivity` definida por reducción
  explícita; uso de `Finset.analyticOn_fun_sum`; nombres del pin para
  `Complex.conj_eq_iff_im`, `Complex.norm_real` y `pow_eq_zero_iff`.

## VERIFICATION — puntos de riesgo originales ya revisados

1. `Finset.analyticOn_sum` / `analyticOn_id` / `AnalyticOn.pow` /
   `analyticOn_const`: en el pin, `AnalyticOn` es la versión "within"
   (post-renombrado AnalyticOn→AnalyticOnNhd de 2024; el propio
   AnalyticClustering.lean del T0 ya usa AnalyticOn y compila, así que el
   tipo existe). Si algún lema puntual falta en versión within, localizar:
   `grep -rn "analyticOn_id\|analyticOn_sum" .lake/packages/mathlib/Mathlib/Analysis/Analytic/`
   (las variantes `AnalyticOnNhd.*` + `.analyticOn` son el fallback).
2. `Complex.norm_conj` (‖conj z‖ = ‖z‖): si el pin lo llama `norm_conj` a
   secas o `RCLike.norm_conj`, ajustar. `Complex.norm_ofReal`: alternativa
   `Complex.norm_real`.
3. Los `show` de Polydisc atraviesan withActivity/diskFamily por defeq
   (estructura con `{ P with activity := ... }`): si el elaborador no
   reduce, añadir `unfold PolymerSystem.withActivity PolymerSystem.diskFamily`
   antes del `show`.
4. `pow_eq_zero_iff (two_ne_zero)`: si la firma del pin pide `(n := 2)`
   explícito u otra hipótesis (`Nat.succ_ne_zero`), ajustar; alternativa
   `sq_eq_zero_iff`.
5. `linear_combination` con `conj z` como átomo: estable (linear_combination
   usa ring, que trata conj z como opaco).
6. `Complex.eq_conj_iff_im`: si la orientación del pin es `conj_eq_iff_im`,
   usar `(Complex.conj_eq_iff_im.mp hzc.symm)`.
7. En `hxeq`, `exact_mod_cast hz'` tras `rw [hre] at hz'`: si norm_cast no
   colapsa `((2*c:ℝ):ℂ)*(↑x)`, anteponer `push_cast at hz'`.
8. La instancia `Fintype (P.withActivity z).Polymer`: se hereda por defeq;
   si la resolución de instancias no la ve, añadir
   `haveI : Fintype (P.withActivity z).Polymer := ‹Fintype P.Polymer›`
   al principio de los teoremas afectados.

## Qué gana el madre con este empuje

Su primer consumidor externo devuelve valor aguas arriba en la primera
iteración: la capa KP, tal como está formulada, ya implica la versión
región de su propio teorema (el polidisco entero con un solo peso), y la
sección de fugacidad es un polinomio explícito — dos hechos que el madre
puede adoptar upstream con 6 líneas de definiciones si los quiere. Y el
programa Lee-Yang, que era todo interfaces, tiene ahora caso base probado,
cierre por productos probado y el paso de inducción de Asano enunciado en
su forma clásica verdadera: M2 tiene todos sus engranajes sobre la mesa.
