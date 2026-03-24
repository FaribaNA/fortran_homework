# plot_results.R
.libPaths("~/Rlibs")

library(ggplot2)
library(gridExtra)

# ---------- Read data ----------
hilbert <- read.table("hilbert_results.txt", header = TRUE)
genhilbert <- read.table("generalized_hilbert_results.txt", header = TRUE)

# ---------- Clean data ----------
genhilbert$error[is.nan(genhilbert$error)] <- NA
genhilbert$residual_max[is.nan(genhilbert$residual_max)] <- NA

# ---------- Combine data ----------
error_dt <- rbind(
  data.frame(
    n = hilbert$n,
    value = hilbert$error,
    type = "Hilbert"
  ),
  data.frame(
    n = genhilbert$n,
    value = genhilbert$error,
    type = "Generalized Hilbert"
  )
)

res_dt <- rbind(
  data.frame(
    n = hilbert$n,
    value = hilbert$residual_max,
    type = "Hilbert"
  ),
  data.frame(
    n = genhilbert$n,
    value = genhilbert$residual_max,
    type = "Generalized Hilbert"
  )
)

# ---------- Error plot ----------
p1 <- ggplot(error_dt, aes(x = n, y = value, color = type)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_vline(xintercept = 47, linetype = "dashed") +
  annotate(
    "text",
    x = 47,
    y = max(genhilbert$error, na.rm = TRUE),
    label = "Breakdown at n = 47",
    angle = 90,
    vjust = -0.4,
    hjust = 1,
    size = 4
  ) +
  scale_y_log10() +
  labs(
    title = "Error comparison",
    x = "Matrix size (n)",
    y = "max|x - x_exact|",
    color = ""
  ) +
  theme_minimal(base_size = 16)

# ---------- Residual plot ----------
p2 <- ggplot(res_dt, aes(x = n, y = value, color = type)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_vline(xintercept = 47, linetype = "dashed") +
  annotate(
    "text",
    x = 47,
    y = max(genhilbert$residual_max, na.rm = TRUE),
    label = "Breakdown at n = 47",
    angle = 90,
    vjust = -0.4,
    hjust = 1,
    size = 4
  ) +
  scale_y_log10() +
  labs(
    title = "Residual comparison",
    x = "Matrix size (n)",
    y = "max|Ax - b|",
    color = ""
  ) +
  theme_minimal(base_size = 16)

# ---------- Arrange ----------
combined_plot <- grid.arrange(
  p1, p2,
  ncol = 1
)

# ---------- Save ----------
ggsave(
  "combined_plots.png",
  combined_plot,
  width = 10,
  height = 11,
  dpi = 300
)