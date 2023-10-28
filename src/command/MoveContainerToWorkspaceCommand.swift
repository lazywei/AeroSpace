struct MoveContainerToWorkspaceCommand: Command {
    let targetWorkspaceName: String

    func runWithoutRefresh() async {
        guard let focused = focusedWindow else { return }
        let preserveWorkspace = focused.workspace
        let targetWorkspace = Workspace.get(byName: targetWorkspaceName)
        let targetContainer: NonLeafTreeNode = focused.isFloating ? targetWorkspace : targetWorkspace.rootTilingContainer
        focused.unbindFromParent()
        focused.bind(to: targetContainer, adaptiveWeight: WEIGHT_AUTO) // todo different monitor

        WorkspaceCommand(workspaceName: preserveWorkspace.name).runWithoutRefresh()
    }
}
