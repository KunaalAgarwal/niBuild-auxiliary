# CWL Preview Panel

The right-side panel shows a live preview of the CWL workflow that niBuild will generate from your current canvas. The preview updates automatically as you add, remove, or reconfigure nodes and edges.

- Toggle between the **.cwl** tab (workflow definition) and the **.yml** tab (job template with your parameter values).
- Syntax highlighting: keys in blue, strings in green, booleans in orange, comments in gray.
- Click **Copy** to copy the current tab's content to your clipboard.
- Click **Expand** to view the preview in a fullscreen modal for detailed review.
- Use the toggle button to collapse or expand the panel. Panel state is saved in localStorage.

!!! note
    The preview requires at least one non-I/O node to generate output.
