/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
* BoxBulb power 2 with scaling of z axis
* This formula contains aux.color and aux.actualScaleA

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "BoxFoldBulbPow2V2Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 BoxFoldBulbPow2V2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{

	// tglad fold
	REAL4 oldZ = z;
	if (aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
					- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
		z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
					- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
		z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
					- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor.x;
			if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor.y;
			if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor.z;
		}
	}

	// spherical fold
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{

		REAL rr = dot(z, z);

		z += fractal->mandelbox.offset;

		// if (r2 < 1e-21f) r2 = 1e-21f;
		if (rr < fractal->transformCommon.minR2p25)
		{
			REAL tglad_factor1 =
				native_divide(fractal->transformCommon.maxR2d1, fractal->transformCommon.minR2p25);
			z *= tglad_factor1;
			aux->DE *= tglad_factor1;
			aux->r_dz *= tglad_factor1;
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp1;
			}
		}
		else if (rr < fractal->transformCommon.maxR2d1)
		{
			REAL tglad_factor2 = native_divide(fractal->transformCommon.maxR2d1, rr);
			z *= tglad_factor2;
			aux->DE *= tglad_factor2;
			aux->r_dz *= tglad_factor2;
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp2;
			}
		}
		z -= fractal->mandelbox.offset;
	}
	// scale
	if (aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{

		REAL useScale = aux->actualScaleA + fractal->transformCommon.scale;

		z *= useScale;
		aux->DE = mad(aux->DE, fabs(useScale), 1.0f);
		aux->r_dz *= fabs(useScale);

		if (aux->i >= fractal->transformCommon.startIterationsX
				&& aux->i < fractal->transformCommon.stopIterationsX)
		{
			// update actualScale for next iteration
			REAL vary = fractal->transformCommon.scaleVary0
									* (fabs(aux->actualScaleA) - fractal->transformCommon.scaleB1);
			if (fractal->transformCommon.functionEnabledMFalse)
				aux->actualScaleA = -vary;
			else
				aux->actualScaleA = aux->actualScaleA - vary;
		}
	}

	if (aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		if (fractal->transformCommon.functionEnabledxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledzFalse) z.z = fabs(z.z);

		aux->r = length(z);

		aux->r_dz =
			aux->r * aux->r_dz * 16.0f * fractal->analyticDE.scale1
				* native_divide(native_sqrt(fractal->foldingIntPow.zFactor * fractal->foldingIntPow.zFactor
																		+ 2.0f + fractal->analyticDE.offset2),
						SQRT_3)
			+ fractal->analyticDE.offset1;

		z = z * 2.0f;
		REAL x2 = z.x * z.x;
		REAL y2 = z.y * z.y;
		REAL z2 = z.z * z.z;
		REAL temp = 1.0f - native_divide(z2, (x2 + y2));
		REAL4 zTemp;
		zTemp.x = (x2 - y2) * temp;
		zTemp.y = 2.0f * z.x * z.y * temp;
		zTemp.z = -2.0f * z.z * native_sqrt(x2 + y2);
		zTemp.w = z.w;
		z = zTemp;
		z.z *= fractal->foldingIntPow.zFactor;
	}
	return z;
}