# ADHD-Friendly i3wm Design Decisions

**Target:** 34" Ultrawide Monitor, ADHD developers using terminals/browsers  
**Version:** 1.0  
**Part of:** [dotfiles](README.md) configuration system

## Design Principles

### Focus Management
**Single point of attention**: Only the active window should draw visual focus. Inactive windows fade into the background to eliminate peripheral distractions.

**Predictable behavior**: No animations, transitions, or changing elements that can capture ADHD attention inappropriately.

### Cognitive Load Reduction
**Minimal color palette**: Maximum 4 colors total to prevent decision fatigue and visual overwhelm.

**Consistent patterns**: Same visual elements always mean the same thing across all contexts.

**Visual chunking**: Use whitespace and gaps to help the brain process separate areas of information.

## Layout Strategy

### Workspace Approach
**Fewer workspaces**: 3-4 purpose-specific workspaces rather than 10 generic ones. Reduces choice paralysis and context switching overhead.

### 34" Ultrawide Patterns

#### Three-Column Development
```
┌─────────────────────────────────────────────────────────────────────┐
│ ┌─────────────┐ ┌──────────────────────────┐ ┌─────────────────────┐ │
│ │   TERMINAL  │ │       CODE EDITOR        │ │   BROWSER/DOCS      │ │
│ │             │ │                          │ │                     │ │
│ │ htop        │ │ def process_data():      │ │ Stack Overflow      │ │
│ │ logs        │ │   return clean(data)     │ │ Documentation       │ │
│ │ kubectl     │ │                          │ │ GitHub Issues       │ │
│ │             │ │ class Parser:            │ │                     │ │
│ │             │ │   def __init__(self):    │ │                     │ │
│ └─────────────┘ └──────────────────────────┘ └─────────────────────┘ │
└─────────────────────────────────────────────────────────────────────┘
    25%                    50%                       25%
```
**Use case**: Active development with constant reference lookup. Takes advantage of horizontal space while maintaining comfortable viewing angles.

#### Master-Stack DevOps
```
┌─────────────────────────────────────────────────────────────────────┐
│ ┌──────────────────────────────────────────────────┐ ┌─────────────┐ │
│ │                                                  │ │  KUBECTL    │ │
│ │               MAIN EDITOR/BROWSER                │ │ pod status  │ │
│ │                                                  │ ├─────────────┤ │
│ │  terraform apply                                 │ │  TERMINAL   │ │
│ │  resource "aws_instance" "web" {                 │ │ ssh logs    │ │
│ │    ami           = "ami-123456"                  │ ├─────────────┤ │
│ │    instance_type = "t3.micro"                    │ │ MONITORING  │ │
│ │  }                                               │ │ Grafana     │ │
│ │                                                  │ │ alerts      │ │
│ └──────────────────────────────────────────────────┘ └─────────────┘ │
└─────────────────────────────────────────────────────────────────────┘
                       75%                              25%
```
**Use case**: Infrastructure work and deployment monitoring. Prevents neck strain from extreme edges by keeping tools in easy reach.

#### Deep Focus Mode
```
┌─────────────────────────────────────────────────────────────────────┐
│           ┌──────────────────────────────────────────┐               │
│           │                                          │               │
│           │            CENTERED EDITOR               │               │
│           │                                          │               │
│           │  def quicksort(arr):                     │               │
│           │      if len(arr) <= 1:                  │               │
│           │          return arr                      │               │
│           │                                          │               │
│           │      pivot = arr[len(arr) // 2]         │               │
│           │      left = [x for x in arr if x < p]   │               │
│           │      right = [x for x in arr if x > p]  │               │
│           │                                          │               │
│           └──────────────────────────────────────────┘               │
└─────────────────────────────────────────────────────────────────────┘
   20%                        60%                        20%
```
**Use case**: Complex problem solving and algorithm development. Eliminates peripheral distractions for maximum concentration.

## Visual Design Decisions

### Gap Configuration
**10px inner gaps, 6px outer gaps**: Provides visual separation between windows without wasting screen space. Creates distinct "chunks" that ADHD brains can process separately.

**Smart gaps enabled**: Hides gaps when only one window is open, maximizing screen use for deep focus sessions.

### Border Strategy
**Active window only**: Focused windows get 2px borders, unfocused windows have no borders. Eliminates visual noise while providing clear focus indication.

**No border animations**: Static borders prevent attention from being drawn to irrelevant window state changes.

## Color Scheme

### Terminal Colors: True Black Theme
**Background**: #000000 (pure black for maximum contrast and minimal distraction)  
**Foreground**: #ffffff (pure white for maximum readability)

**Accent Colors** (minimal usage only):
- **Red**: #ef4444 (errors only)
- **Green**: #16a34a (success states only)  
- **Blue**: #569cd6 (information only)
- **Yellow**: #facc15 (warnings only, sparingly)

**Rationale**: Pure black background eliminates all visual noise. High contrast white text ensures maximum readability. Extremely limited color palette (only 4 colors total) prevents ADHD overstimulation and cognitive overload.

### Border Colors
**Primary**: #4ec9b0 (cyan) - Calming, professional, high contrast against black terminals. Not overstimulating.

**Qubes VM Coding** (for security awareness):
- **Work VM**: #2563eb (blue)
- **Personal VM**: #16a34a (green)  
- **Disposable VM**: #ea580c (orange)
- **System VM**: #6b7280 (gray)

### Background
**Desktop**: #0a0a0a (dark gray) - Creates subtle window definition while maintaining dark aesthetic.

## Typography

### Primary Font: JetBrains Mono
**Rationale**: Designed for code readability. Clear distinction between similar characters (0/O, 1/l/I). Reduces cognitive load from character confusion.

**Size**: 14-16px for 34" viewing distance. Large enough to prevent eye strain.

### Terminal Prompt Design
**Minimal approach**: Path and git branch only. Eliminates visual clutter and information overload that can distract ADHD users.

## Rationale Summary

### Why These Decisions Work for ADHD

**Reduced stimulation**: True black terminals with minimal colors prevent overstimulation that can trigger hyperfocus or distraction.

**Clear hierarchy**: Cyan borders and gaps create obvious visual priority without competing elements.

**Consistent meaning**: Colors always represent the same concepts (red = error, green = success, etc.).

**Spatial organization**: Gaps and layouts help ADHD brains compartmentalize different types of information.

**Reduced decision fatigue**: Fewer workspaces and consistent patterns minimize daily micro-decisions that drain mental energy.

**Eye strain prevention**: High contrast ratios and minimal color stimulation support long working sessions without fatigue.

## References

### ADHD and Visual Attention
Castellanos, F. X., & Proal, E. (2012). Large-scale brain systems in ADHD: beyond the prefrontal–striatal model. *Trends in Cognitive Sciences*, 16(1), 17-26.

Kahneman, D., & Chajczyk, D. (1983). Tests of the automaticity of reading: dilution of Stroop effects by color-irrelevant stimuli. *Journal of Experimental Psychology: Human Perception and Performance*, 9(4), 497-509.

Nigg, J. T. (2017). Annual research review: On the relations among self‐regulation, self‐control, executive functioning, effortful control, cognitive control, impulsivity, risk‐taking, and inhibition for developmental psychopathology. *Journal of Child Psychology and Psychiatry*, 58(4), 361-383.

### Cognitive Load and Visual Design
Sweller, J. (2011). Cognitive load theory. *Psychology of Learning and Motivation*, 55, 37-76.

Miller, G. A. (1956). The magical number seven, plus or minus two: Some limits on our capacity for processing information. *Psychological Review*, 63(2), 81-97.

Paas, F., Renkl, A., & Sweller, J. (2003). Cognitive load theory and instructional design: Recent developments. *Educational Psychologist*, 38(1), 1-4.

### Color Psychology and ADHD
Mehta, R., & Zhu, R. J. (2009). Blue or red? Exploring the effect of color on cognitive task performances. *Science*, 323(5918), 1226-1229.

Kwallek, N., Woodson, H., Lewis, C. M., & Sales, C. (1997). Impact of three interior color schemes on worker mood and performance relative to individual environmental sensitivity. *Color Research & Application*, 22(2), 121-132.

Singh, S. (2006). Impact of color on marketing. *Management Decision*, 44(6), 783-789.

### Typography and Readability
Dyson, M. C. (2004). How physical text layout affects reading from screen. *Behaviour & Information Technology*, 23(6), 377-393.

Rello, L., & Baeza-Yates, R. (2013). Good fonts for dyslexia. In *Proceedings of the 15th International ACM SIGACCESS Conference on Computers and Accessibility* (pp. 1-8).

Beier, S., & Larson, K. (2013). How does typeface familiarity affect reading performance and reader preference? *Information Design Journal*, 20(1), 16-31.

### Screen Ergonomics and Productivity
Blehm, C., Vishnu, S., Khattak, A., Mitra, S., & Yee, R. W. (2005). Computer vision syndrome: a review. *Survey of Ophthalmology*, 50(3), 253-262.

Hedge, A., & Ray, E. J. (2004). Effects of computer workstation design features on postural risk factors for work-related musculoskeletal disorders. *International Journal of Industrial Ergonomics*, 33(4), 337-347.

### Workspace Organization and ADHD
Zentall, S. S., & Javorsky, J. (2007). Professional development for teachers of students with ADHD and characteristics of ADHD. *Behavioral Disorders*, 32(2), 78-93.

Dupaul, G. J., & Weyandt, L. L. (2006). School-based intervention for children with attention deficit hyperactivity disorder: Effects on academic, social, and behavioural functioning. *International Journal of Disability, Development and Education*, 53(2), 161-176.