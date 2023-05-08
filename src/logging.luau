local logging = {}

function logging.typecheck(condition: boolean, gotType: string, expectedType: string)
	if not condition then
		logging.error(`expected type { expectedType }, got { gotType }`)
	end
end

function logging.error(errorMessage: string)
	error(`[fsPanel] { errorMessage }`)
end

function logging.warn(warnMessage: string)
	warn(`[fsPanel] { warnMessage }`)
end

function logging.print(printMessage: string)
	print(`[fsPanel] { printMessage }`)
end

return logging