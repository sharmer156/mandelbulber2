/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * rotation variation v1. Rotation angles vary linearly between iteration parameters.

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfRotationVaryV1Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfRotationVaryV1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 tempVC = (REAL4){fractal->transformCommon.rotation.x, fractal->transformCommon.rotation.y,
		fractal->transformCommon.rotation.z, 0.0f}; // constant to be varied

	if (aux->i >= fractal->transformCommon.startIterations250
			&& aux->i < fractal->transformCommon.stopIterations
			&& (fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250
					 != 0))
	{
		int iterationRange =
			fractal->transformCommon.stopIterations - fractal->transformCommon.startIterations250;
		int currentIteration = (aux->i - fractal->transformCommon.startIterations250);
		tempVC += fractal->transformCommon.offset000 * native_divide(currentIteration, iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterations)
	{
		tempVC = (tempVC + fractal->transformCommon.offset000);
	}

	tempVC *= M_PI_180;

	z = RotateAroundVectorByAngle4(z, (REAL3){1.0f, 0.0f, 0.0f}, tempVC.x);
	z = RotateAroundVectorByAngle4(z, (REAL3){0.0f, 1.0f, 0.0f}, tempVC.y);
	z = RotateAroundVectorByAngle4(z, (REAL3){0.0f, 0.0f, 1.0f}, tempVC.z);
	return z;
}