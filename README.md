# 🏙️ CityChain: On-Chain City Name Challenge

A fully on-chain, multiplayer word game where players name **cities** one after another — each starting with the **last valid letter** of the previous. All moves are stored immutably on Ethereum-compatible blockchains via smart contract.

---

## 🚀 Features

- ✅ 100% On-chain gameplay
- 🧠 Letter logic supports Cyrillic (ignores ь, ъ, ы)
- 🔒 Prevents repeated cities
- 🕒 Auto-reset after timeout (1 day of inactivity)
- 📜 Public game history

---

## 🎮 How to Play

1. First player submits any real city name.
2. Each next city must begin with the last valid letter of the previous one.
3. Cities **must not repeat**.
4. If no moves for 24h, anyone can **reset the game**.

---

## ✍️ Example

```text
Player 1: Москва
Player 2: Астана ✅ (starts with А)
Player 3: Алматы ✅ (starts with А)
Player 4: Ысык-Көл ❌ (invalid - starts with Ы)
