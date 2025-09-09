:control_knobs: **MT ELEVATOR**
**Frameworks:** QBCore / QBX / ESX

:rocket: A comprehensive elevator system for FiveM, based on MT-Scripts/mt\_elevator. Now extended with extra features for flexibility, stability & customization.

---

:sparkles: **FEATURES**
:green_circle: Multi-framework support: QBCore, QBX (ox\_lib notify), ESX
:green_circle: Job restrictions: only allowed jobs & grades can use elevators
:green_circle: Dynamic checks: resource start, player reload & job updates
:green_circle: Configurable sounds: GTA default :musical_note: or custom `.awc` :notes:
:green_circle: Notifications per framework:

* **QBCore:** `QBCore.Functions.Notify`
* **QBX:** `lib.notify` (ox\_lib)
* **ESX:** `ESX.ShowNotification`
  :green_circle: NUI menu: React interface for floor selection, integrated with `ox_target` zones
  :green_circle: Dynamic job updates on job change or resource reload
  :green_circle: Fallback: console messages if notify is unavailable
  :green_circle: Extra access checks based on job & grade

---

:gear: **CONFIGURATION EXAMPLES**

**:police_officer: Jobs Example:**

```lua
Config.Jobs = {
    ["police"] = {
        {
            level = 1,
            grade = {0,1,2,3,4,5,6,7,8,9},
            ped = vec4(464.78, -977.15, 30.72, 120.06),
            target = { coords = vec3(463.69, -977.87, 30.72), radius = 1.2 }
        }
    }
}
```

**:loud_sound: Sound Settings:**

```lua
Config.Sound = {
    type = "default",  -- Options: "default" or "custom"
    default = { name = "ATM_WINDOW", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" },
    custom  = { name = "elevator", set = "elevator_soundset" }
}
```

**:musical_note: Available GTA Standard Sounds:** `ATM_WINDOW`, `SELECT`, `CANCEL`, `NO`, `YES`, `MEDAL_UP`, `BASE_JUMP_PASSED`

---

:tools: **INSTALLATION**
:one: Place the resource in `resources/`
:two: Ensure `ox_lib` and `ox_target` are installed
:three: Add to `server.cfg`: `ensure mt_elevator`
:four: Set your core in `config.lua`: `Config.Core = 'qbx'` (or `'qb'`, `'esx'`)
:five: Set sound type: `Config.Sound.type = "default"` or `"custom"`

---

:trophy: **CREDITS**

* Original script: MT-Scripts/mt\_elevator
* Modifications & extensions: **By Bigchief'**

  * Multi-core support (QBCore / QBX / ESX)
  * Dynamic job sync
  * Configurable sounds (default & custom)
  * Improved notify integration
  * NUI interface & `ox_target` integration
  * Extra access checks & fallback options

:star2: Enjoy your fully functional elevator system!
