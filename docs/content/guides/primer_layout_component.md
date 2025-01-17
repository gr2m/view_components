---
title: Moving Away From `Primer::LayoutComponent`
---

This guide will show you how to upgrade from the now-deprecated
[`Primer::LayoutComponent`](https://primer.style/view-components/components/layout)
to the latest
[`Primer::Alpha::Layout`](https://primer.style/view-components/components/alpha/layout)
component.

## Features and Examples

`Primer::Alpha::Layout` deprecates some arguments and also provides a few new
capabilities.

### Sidebar width

The deprecated `Primer::LayoutComponent` configures sidebar width as an integer
number of columns. With `Primer::Alpha::Layout` we set the sidebar width to one
of `:default`, `:narrow`, or `:wide`. Those correspond to numbers that vary
according to the layout's breakpoint; see the [the component's
documentation](https://primer.style/view-components/components/alpha/layout#sidebar-widths)
for specific breakpoint widths.

For example, to create a narrower sidebar:

```rb
<%= render(Primer::Alpha::Layout.new) do |component| %>
  <% component.with_main { "Main" } %>
  <% component.with_sidebar(width: :narrow) { "Sidebar" } %>
<% end %>
```

### Sidebar placement

Sidebar placement was previously limited to either `:left` or `:right`. We can
still configure those, but we can also now configure whether the sidebar should
be above or below the main content when breaking into row mode.

For example, suppose we previously had a sidebar on the left, and would like it
to be above the main content when the page breaks into row mode.

With `Primer::LayoutComponent` we'd probably have something like this:

```rb
<%= render(Primer::LayoutComponent.new(side: :left)) do |component| %>
  <% component.with_sidebar { "Sidebar" } %>
  <% component.with_main { "Main" } %>
<% end %>
```

When migrating to `Primer::Alpha::Layout` we might try:

```rb
<%= render(Primer::Alpha::Layout.new) do |component| %>
  <% component.with_main { "Main" } %>
  <% component.with_sidebar(col_placement: :start, row_placement: :start) { "Sidebar" } %>
<% end %>
```

To keep the sidebar *below* the main content, though, we could've set
`row_placement: :end`, or hidden it entirely with `row_placement: :none`.

### Reordering keyboard order

We might want to manually set the focus order for keyboard navigation for
accessibility reasons. Under `Primer::LayoutComponent` we might reorder the
components in the source, but `Primer::Alpha::LayoutComponent` can override that
with the `first_in_source` argument, which can be either `:main` or `:sidebar`.

For example, to ensure that keyboard focus always visits the sidebar before the
main content:

```rb
<%= render(Primer::Alpha::Layout.new(first_in_source: :sidebar)) do |component| %>
  <% component.with_main { "Main" } %>
  <% component.with_sidebar { "Sidebar" } %>
<% end %>
```

### Specific breakpoints to control responsiveness

Where previously `Primer::LayoutComponent` only offered `responsiveness: true`
to enable a breakpoint, we can now be more specific by setting the
`stacking_breakpoint` argument to one of `:sm`, `:med`, or `:lg`. Setting a
larger breakpoint will cause the layout to shift into row mode on a wider
screen.

For example, to retain columns on a smaller screen:

```rb
<%= render(Primer::Alpha::Layout.new(stacking_breakpoint: :sm)) do |component| %>
  <% component.with_main { "Main" } %>
  <% component.with_sidebar { "Sidebar" } %>
<% end %>
```

### Configurable gutter width

`Primer::Alpha::Layout` includes a new `gutter` argument to configure the width
of the gutter between the sidebar and main content, which can be one of `:none`,
`:condensed`, `:default`, or `:spacious`.

For example, to create an especially roomy gutter:

```rb
<%= render(Primer::Alpha::Layout.new(gutter: :spacious)) do |component| %>
  <% component.with_main { "Main" } %>
  <% component.with_sidebar { "Sidebar" } %>
<% end %>
```

## Arguments

The following arguments are different between `Primer::LayoutComponent` and
`Primer::Alpha::Layout`:

| From `Primer::LayoutComponent` | To `Primer::Alpha::Layout` | Notes                                                                                                                                                    |
|--------------------------------|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| `responsive`                   | `stacking_breakpoint`      | When to collapse from columns to rows. Previously a Boolean, now one of `:lg`, `:med`, or `:sm`.                                                         |
| n/a                            | `first_in_source`          | Which element to render first in HTML, determining keyboard navigation order. Either `:main` or `:sidebar`.                                              |
| n/a                            | `gutter`                   | Amount of space between the sidebar and main section. One of `:none`, `:condensed`, `:default`, or `:spacious`.                                          |
| `side`                         | n/a                        | Which side should the sidebar be on? Previously either `:right` or `:left`, now handled by the `col_placement` and `row_placement` slots on the sidebar. |
| `sidebar_col`                  | n/a                        | Width of the sidebar in columns. Now handled by the `width` slot on the sidebar.                                                                         |

The main and sidebar components also have some new, additional slots.

New on the `main` component:

* `width`: One of `:full`, `:xl`, `:lg`, or `:med`. A `:full` width will stretch
  the main column to cover all available space.

New on the `sidebar` component:

* `width`: One of `:default`, `:narrow`, or `:wide`. Replaces the deprecated
  `Primer::LayoutComponent#sidebar_col` argument.
* `col_placement`: Sidebar placement in column mode. One of `:start` or `:end`.
  Use this in combination with `row_placement` to duplicate the functionality of
  the deprecated `Primer::LayoutComponent#side` argument.
* `row_placement`: Sidebar placement in row mode. One of `:start`, `:end`, or `:none`.

Please see the following documentation for complete descriptions and examples.

* [Deprecated `Primer::LayoutComponent`](https://primer.style/view-components/components/layout)
* [`Primer::Alpha::Layout` component](https://primer.style/view-components/components/alpha/layout)
* [`Primer::Alpha::Layout` Lookbook examples](https://primer.style/view-components/lookbook/inspect/primer/alpha/layout/default)

<p>&nbsp;</p>

[&larr; Back to migration guides](https://primer.style/view-components/migration)
