import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

# Set up the plot
fig, ax = plt.subplots(figsize=(10, 6))
ax.axis('off')

# Draw your design
ax.text(0.1, 0.9, "Your Design", fontsize=14, weight='bold')
ax.text(0.1, 0.82, "Instrument + Location", bbox=dict(boxstyle="round,pad=0.3", fc="lightblue"))
ax.text(0.1, 0.70, "↓", fontsize=16, ha='center')
ax.text(0.1, 0.60, "Moniker Set", bbox=dict(boxstyle="round,pad=0.3", fc="lightgreen"))
ax.text(0.1, 0.48, "↓", fontsize=16, ha='center')
ax.text(0.1, 0.38, "Price Published", bbox=dict(boxstyle="round,pad=0.3", fc="lightyellow"))

# Draw BA's design
ax.text(0.6, 0.9, "BA's Suggested Design", fontsize=14, weight='bold')
ax.text(0.6, 0.82, "Instrument + Location", bbox=dict(boxstyle="round,pad=0.3", fc="lightblue"))
ax.text(0.6, 0.70, "↓", fontsize=16, ha='center')
ax.text(0.6, 0.60, "Position", bbox=dict(boxstyle="round,pad=0.3", fc="lightsalmon"))
ax.text(0.6, 0.48, "↓", fontsize=16, ha='center')
ax.text(0.6, 0.38, "Moniker Set", bbox=dict(boxstyle="round,pad=0.3", fc="lightgreen"))
ax.text(0.6, 0.26, "↓", fontsize=16, ha='center')
ax.text(0.6, 0.16, "Price Published", bbox=dict(boxstyle="round,pad=0.3", fc="lightyellow"))

# Add comparison legend
simple_patch = mpatches.Patch(color='lightblue', label='Key Input')
intermediate_patch = mpatches.Patch(color='lightsalmon', label='BA’s Extra Layer')
moniker_patch = mpatches.Patch(color='lightgreen', label='Moniker Resolution')
output_patch = mpatches.Patch(color='lightyellow', label='Price Output')
ax.legend(handles=[simple_patch, intermediate_patch, moniker_patch, output_patch], loc='lower center', bbox_to_anchor=(0.5, -0.05), ncol=4)

plt.tight_layout()
plt.show()
