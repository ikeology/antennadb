# AntennaDB

A relational graph database modeling antenna performance through the lens of signal gain, environmental interaction, and physical construction.

## Overview

An antenna is a device that transmits and receives electromagnetic energy, forming the essential link between electronic equipment and the surrounding environment. Although antennas are embedded in nearly all modern devices, they are rarely classified, described, or even visible to consumers — in part because antennas are inherently relational components. Their performance depends not only on physical design but on how they interact with other elements in a system: line-of-sight, devices, mounting locations, signal paths, frequency bands, and environmental conditions.

Most manufacturer specifications treat antenna gain as a fixed, isolated attribute. AntennaDB models it instead as a relationship — connecting antenna types, use cases, gain values, manufacturers, and the environmental and material conditions that shape real-world performance. By representing antennas within a connected graph rather than a flat table, the project illustrates how many-to-many relationships, rather than isolated specs, define how antennas actually behave.

## Research Questions

1. What performance characteristics do antennas exhibit (point-to-point links, roaming capability, transmission efficiency, reception sensitivity)?
2. How do environmental conditions — weather, vegetation, temperature — affect antenna gain and overall performance?
3. How does antenna strength vary from commercial to consumer products (e.g., a long-range directional antenna vs. an iPhone's built-in antenna)?
4. How do routing protocols, device configuration, frequency selection, and congestion interact with antenna performance in integrated platforms?
5. What materials are antennas constructed from, and how do variations in conductor type (copper, aluminum, composite materials) influence performance?

## Schema

The database is normalized to second normal form (2NF), with antenna gain modeled as a relationship rather than a product-level property — reflecting the fact that performance characteristics are intrinsic to antenna design and apply across multiple devices and use cases.

### Core relationships

| Relationship | From Node | To Node | Purpose | Example |
|---|---|---|---|---|
| `OPTIMIZED_FOR` | AntennaType | UseCase | Describes the intended functional role of an antenna design | Directional Panel → Point-to-Point |
| `USES_ANTENNA_TYPE` | Product | AntennaType | Links a product to the antenna design it employs | Ubiquiti airMAX SXT 5 → Directional Panel |
| `HAS_GAIN` | AntennaType | Gain | Represents antenna gain as a reusable performance characteristic | Phased Array → 20 dBi |
| `MANUFACTURED_BY` | Product | Manufacturer | Links a product to its manufacturer | Apple iPhone 17 → Apple Inc. |

## Sample Queries

**Compare gain across device classes** (e.g., smartphone vs. satellite antenna):

```cypher
MATCH (a:AntennaType)-[:HAS_GAIN]->(g:Gain)
RETURN a.antennaTypeId, g.value
ORDER BY g.value;
```

**Identify antennas with commercial-grade gain** (≥10 dBi, directional):

```cypher
MATCH (a:AntennaType)-[:HAS_GAIN]->(g:Gain)
WHERE a.coverageType = 'Directional' AND g.value >= 10
RETURN a.antennaTypeId, g.value;
```

**Identify what an antenna type is optimized for:**

```cypher
MATCH (a:AntennaType)-[:OPTIMIZED_FOR]->(u:UseCase {name: "Point-to-Point"})
RETURN a.name AS AntennaType;
```

**Cross-reference manufacturers, products, and performance:**

```cypher
MATCH (m:Manufacturer)-[:MANUFACTURES]->(p:Product)-[:USES_ANTENNA_TYPE]->(a:AntennaType)
OPTIONAL MATCH (a)-[:HAS_GAIN]->(g:Gain)
RETURN
  m.name AS Manufacturer,
  p.name AS Product,
  a.name AS AntennaType,
  g.value + " " + g.unit AS Gain,
  p.coverage AS Coverage
ORDER BY Manufacturer, Product;
```

**Map products and manufacturers to supported radio interfaces:**

```cypher
MATCH (m:Manufacturer)-[:MANUFACTURES]->(p:Product)-[:SUPPORTS_INTERFACE]->(r:RadioInterface)
RETURN
  m.name AS Manufacturer,
  p.name AS Product,
  r.description AS RadioInterface,
  r.mimo AS MIMO
ORDER BY Manufacturer, Product;
```

## Primary Source

Device and antenna specifications were referenced against the [FCC Equipment Authorization Search](https://www.fcc.gov/licensing-databases/search-fcc-databases) for granted filings.

## Why a Graph Model

This approach enables end-to-end analysis of antennas across vastly different scales — from smartphone roaming antennas to high-gain satellite phased arrays — tracing how design choices propagate through connected components. Rather than treating antenna specifications as isolated attributes, the database models how connectivity emerges from relationships: a product using a specific antenna type, that antenna type optimized for a particular use case, and its performance expressed through shared gain characteristics that are reusable across the graph.

The result is a model that does more than store specifications — it captures the ecology of relationships that transform electromagnetic theory into working communication systems, enabling queries and insights difficult to represent in traditional flat or relational databases.

## Author

Isaiah Scott
DIGS Data Management, University of Chicago — Autumn 2025

## License

MIT
