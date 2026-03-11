/**
 * jj Checkpoint Hook
 *
 * Snapshots the working copy at each turn boundary so /branch can restore code state.
 * Uses jj operation IDs — `jj op restore` recovers the full repo state.
 */
export default function hook(pi) {
	const checkpoints = new Map();
	let currentEntryId;

	pi.on("tool_result", async (_event, ctx) => {
		const leaf = ctx.sessionManager.getLeafEntry();
		if (leaf) currentEntryId = leaf.id;
	});

	pi.on("turn_start", async () => {
		try {
			// Snapshot working copy, then record the operation ID.
			// This captures repo state before the LLM makes changes.
			await pi.exec("jj", ["status"]);
			const { stdout } = await pi.exec("jj", [
				"operation", "log", "--no-graph", "--limit", "1",
				"-T", "self.id().short(16)",
			]);
			const opId = stdout.trim();
			if (opId && currentEntryId) {
				checkpoints.set(currentEntryId, opId);
			}
		} catch {
			// Not a jj repo — nothing to checkpoint.
		}
	});

	pi.on("turn_end", async () => {
		try {
			// Snapshot so jj captures everything the LLM changed this turn.
			await pi.exec("jj", ["status"]);
		} catch {
			// Not a jj repo.
		}
	});

	pi.on("session_before_branch", async (event, ctx) => {
		const opId = checkpoints.get(event.entryId);
		if (!opId || !ctx.hasUI) return;

		const choice = await ctx.ui.select("Restore code state?", [
			"Yes, restore to that point",
			"No, keep current code",
		]);

		if (choice?.startsWith("Yes")) {
			await pi.exec("jj", ["operation", "restore", opId]);
			ctx.ui.notify("Code restored to checkpoint", "info");
		}
	});

	pi.on("agent_end", async () => {
		checkpoints.clear();
	});
}
