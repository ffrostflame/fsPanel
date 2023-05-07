local logging = {}

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