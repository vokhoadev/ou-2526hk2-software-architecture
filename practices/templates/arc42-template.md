# [System Name] - Architecture Documentation

**Version**: 1.0
**Date**: YYYY-MM-DD
**Author**: [Name]

---

## 1. Introduction and Goals

### 1.1 Requirements Overview

[High-level requirements and business goals]

### 1.2 Quality Goals

| Priority | Quality Goal | Scenario |
|----------|--------------|----------|
| 1 | [Goal] | [Scenario] |
| 2 | [Goal] | [Scenario] |
| 3 | [Goal] | [Scenario] |

### 1.3 Stakeholders

| Role | Expectations |
|------|--------------|
| [Role] | [What they expect] |

---

## 2. Constraints

### 2.1 Technical Constraints

| Constraint | Background |
|------------|------------|
| [Constraint] | [Reason] |

### 2.2 Organizational Constraints

| Constraint | Background |
|------------|------------|
| [Constraint] | [Reason] |

### 2.3 Conventions

| Convention | Description |
|------------|-------------|
| [Convention] | [Description] |

---

## 3. Context and Scope

### 3.1 Business Context

[Diagram showing system in business context]

```
[External System 1] <---> [Our System] <---> [External System 2]
```

| Partner | Description |
|---------|-------------|
| [Partner] | [Description] |

### 3.2 Technical Context

[Technical interfaces and protocols]

| Channel | Input | Output |
|---------|-------|--------|
| [Channel] | [Input] | [Output] |

---

## 4. Solution Strategy

[Key architectural decisions and strategies]

| Goal | Approach |
|------|----------|
| [Goal] | [How we achieve it] |

---

## 5. Building Block View

### 5.1 Level 1: Overall System

[Component diagram showing major components]

```
┌─────────────────────────────────────┐
│ [System Name] │
├─────────────┬─────────────┬─────────┤
│ [Component1]│ [Component2]│[Comp3] │
└─────────────┴─────────────┴─────────┘
```

### 5.2 Level 2: [Subsystem]

[Detailed view of subsystem]

---

## 6. Runtime View

### 6.1 [Scenario 1]

[Sequence diagram or description]

```
Actor -> ComponentA: Request
ComponentA -> ComponentB: Process
ComponentB --> ComponentA: Result
ComponentA --> Actor: Response
```

### 6.2 [Scenario 2]

[Sequence diagram or description]

---

## 7. Deployment View

### 7.1 Infrastructure Level 1

[Deployment diagram]

```
┌─────────────────────────────────────┐
│ Cloud │
├─────────────┬─────────────┬─────────┤
│ Server 1 │ Server 2 │ DB │
│ [Service] │ [Service] │[Storage]│
└─────────────┴─────────────┴─────────┘
```

### 7.2 Infrastructure Level 2

[Detailed deployment for specific environment]

---

## 8. Crosscutting Concepts

### 8.1 Domain Model

[Core domain concepts]

### 8.2 Security

[Security concepts and measures]

### 8.3 Logging & Monitoring

[Logging and monitoring approach]

### 8.4 Error Handling

[Error handling strategy]

---

## 9. Architecture Decisions

| ADR | Decision | Status |
|-----|----------|--------|
| ADR-001 | [Decision] | Accepted |
| ADR-002 | [Decision] | Accepted |

[Link to detailed ADRs]

---

## 10. Quality Requirements

### 10.1 Quality Tree

```
Quality
├── Performance
│ ├── Response time < 200ms
│ └── Throughput > 1000 req/s
├── Availability
│ └── 99.9% uptime
└── Security
 └── OWASP Top 10 compliant
```

### 10.2 Quality Scenarios

| ID | Scenario | Priority |
|----|----------|----------|
| Q1 | [Scenario] | High |
| Q2 | [Scenario] | Medium |

---

## 11. Risks and Technical Debt

### 11.1 Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk] | High/Med/Low | High/Med/Low | [Mitigation] |

### 11.2 Technical Debt

| Item | Description | Priority |
|------|-------------|----------|
| [Item] | [Description] | High/Med/Low |

---

## 12. Glossary

| Term | Definition |
|------|------------|
| [Term] | [Definition] |

---

## Appendix

### A. References

- [Reference 1]
- [Reference 2]

### B. Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial version |
